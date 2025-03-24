import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/tools.dart';
import 'package:sizer/sizer.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../core/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String answer = "";
  CameraController? cameraController;
  CameraImage? cameraImage;

  late Interpreter interpreter;
  late List<String> labels;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(Assets.assetsModelUnquant);
    interpreter.allocateTensors(); // ← مهم جدًا
    final rawLabels = await rootBundle.loadString(Assets.assetsLabels);
    labels = rawLabels.split("\n");

    log("Input shape: ${interpreter.getInputTensor(0).shape}");
    log("Output shape: ${interpreter.getOutputTensor(0).shape}");
  }

  void initCamera() async {
    final cameras = await availableCameras();
    final backCam = cameras
        .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back);

    cameraController = CameraController(backCam, ResolutionPreset.medium);
    await cameraController!.initialize();
    cameraController!.startImageStream((image) {
      if (!isDetecting) {
        isDetecting = true;
        cameraImage = image;
        applyModelOnImage();
      }
    });

    setState(() {});
  }

  Future<void> applyModelOnImage() async {
    if (cameraImage == null) return;

    img.Image image = _convertYUV420toImage(cameraImage!);
    img.Image resized =
        img.copyResize(image, width: 224, height: 224); // حسب حجم الموديل

    Float32List input = imageToFloat32List(resized);
    List<List<double>> output = List.generate(1, (_) => List.filled(3, 0));

// مهم: reshape للـ input
    interpreter.run(input.reshape([1, 224, 224, 3]), output);

    int maxIndex = output[0]
        .indexWhere((e) => e == output[0].reduce((a, b) => a > b ? a : b));

    setState(() {
      answer = labels[maxIndex];
    });

    isDetecting = false;
  }

  // تحويل الصورة إلى Float32List وتطبيق normalization يدويًا
  Float32List imageToFloat32List(img.Image image) {
    final int width = 224;
    final int height = 224;
    final int size = width * height * 3;

    Float32List floatList = Float32List(size);
    int index = 0;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixel = image.getPixel(x, y);
        floatList[index++] = (img.getRed(pixel) - 127.5) / 127.5;
        floatList[index++] = (img.getGreen(pixel) - 127.5) / 127.5;
        floatList[index++] = (img.getBlue(pixel) - 127.5) / 127.5;
      }
    }

    return floatList;
  }

  img.Image _convertYUV420toImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final img.Image imgImage = img.Image(width, height);

    final plane = image.planes[0];
    final bytes = plane.bytes;

    int pixelIndex = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int pixel = bytes[pixelIndex++];
        imgImage.setPixel(x, y, img.getColor(pixel, pixel, pixel));
      }
    }

    return img.copyRotate(imgImage, 90); // تعديل الاتجاه لو لازم
  }

  @override
  void dispose() {
    interpreter.close();
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate sign language'),
      ),
      drawer: DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: cameraController == null ? 55.h : null,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              elevation: 30,
              child: Center(
                child: cameraController != null
                    ? cameraController?.value.isInitialized == true
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: CameraPreview(cameraController!),
                              ),
                              Positioned(
                                bottom: 32,
                                left: 16,
                                right: 16,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  color: Colors.black.withAlpha(126),
                                  child: Text(
                                    answer,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Start translate sign language using camera by pressing start translate below',
                          style: tstyle(context).headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: darkGray,
                              ),
                        ),
                      ),
              ),
            ),
          ),
          vSpace(5),
          ElevatedButton(
            onPressed: () {
              initCamera();
            },
            child: Text('Start Translate'),
          ),
          vSpace(2),
          ElevatedButton(
            onPressed: () {
              if (cameraController != null) {
                cameraController!.dispose();
                cameraController = null;
                setState(() {});
              }
            },
            child: Text('Stop Translate'),
          ),
        ],
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: yellowBG,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Image.asset(
              Assets.assetsLogo,
              height: 200,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: redAccent,
            ),
          ),
          ListTile(
            title: Text('Learn'),
            onTap: () {
              Navigator.pushNamed(context, '/learn');
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: redAccent,
            ),
          ),
          ListTile(
            title: Text('Donat'),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: redAccent,
            ),
          ),
          ListTile(
            title: Text('Service'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: redAccent,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/service');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: redAccent,
            ),
          ),
          ListTile(
            title: Text('Languages'),
            trailing: DropdownButton(
              hint: Text('English'),
              items: [
                DropdownMenuItem(
                  value: 'ar',
                  child: Text('العربية'),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
              ],
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }
}
