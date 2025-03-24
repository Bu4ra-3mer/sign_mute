import 'package:flutter/services.dart';
import 'package:sign_mute/constants/assets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class SignModel {
  late Interpreter interpreter;
  late List<String> labels;

  Future<void> loadModel() async {
    // تحميل الموديل
    interpreter = await Interpreter.fromAsset(Assets.assetsModelUnquant);

    // تحميل الليبلز
    final rawLabels = await rootBundle.loadString(Assets.assetsLabels);
    labels = rawLabels.split('\n');
  }

  Future<String> runModel(List inputData) async {
    var output = List.filled(labels.length, 0).reshape([1, labels.length]);

    // تشغيل الموديل
    interpreter.run(inputData, output);

    // استخراج النتيجة
    int predictedIndex = output[0]
        .indexWhere((e) => e == output[0].reduce((a, b) => a > b ? a : b));
    return labels[predictedIndex];
  }
}
