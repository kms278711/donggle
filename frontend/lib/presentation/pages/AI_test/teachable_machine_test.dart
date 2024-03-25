import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/camera.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:tflite_v2/tflite_v2.dart';

class TeachableMachineTest extends StatefulWidget {
  final CameraDescription camera;

  const TeachableMachineTest(this.camera, {super.key});

  @override
  State<TeachableMachineTest> createState() => _TeachableMachineTestState();
}

class _TeachableMachineTestState extends State<TeachableMachineTest> {
  // late Interpreter interpreter;
  late List<String> labels;
  String predOne = '';
  double confidence = 0;
  double index = 0;
  bool modelLoaded = false;

  @override
  void initState() {
    super.initState();
    loadTfliteModel().then((_) {
      if (mounted) {
        setState(() {
          modelLoaded = true;
        });
      }
    });
  }

  loadTfliteModel() async {
    // interpreter = await Interpreter.fromAsset("assets/tflite/model_unquant.tflite");
    String? res;
    res = await Tflite.loadModel(model: "assets/tflite/model_unquant_new.tflite", labels: "assets/tflite/labels_new.txt");
    print(res);
    // print("Model loaded successfully");
  }

  setRecognitions(outputs) {
    print("[*] $outputs");

    if (outputs[0]['index'] == 0) {
      index = 0;
    } else if (outputs[0]['index'] == 1) {
      index = 1;
    } else {
      index = 2;
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build method now only contains UI code
    return DefaultTextStyle(
      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMedium),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(217, 217, 217, 0.9),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Image.asset("assets/images/test_img.png"),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                left: MediaQuery.of(context).size.width * 0.05,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: const Text(
                  "이 도끼가 당신의 도끼인가요?",
                  textAlign: TextAlign.center,
                )),
            modelLoaded
                ? Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.width * 0.05,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: FittedBox(fit: BoxFit.cover, child: Camera(widget.camera, setRecognitions)),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                            Text(
                              "Prediction: $predOne",
                              style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmallEng),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.width * 0.01,
              child: IconButton(
                icon: const CloseCircle(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
