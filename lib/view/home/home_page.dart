import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:sign_mute/core/tools.dart';
import 'package:sizer/sizer.dart';

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

  late List<String> labels;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
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
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
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
