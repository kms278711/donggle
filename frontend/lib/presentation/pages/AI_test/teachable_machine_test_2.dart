import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


class TeachableMachineTest2 extends StatefulWidget {
  final CameraDescription camera;

  const TeachableMachineTest2(this.camera, {super.key});

  @override
  State<TeachableMachineTest2> createState() => _TeachableMachineTest2State();
}

class _TeachableMachineTest2State extends State<TeachableMachineTest2> {
  late Interpreter interpreter;
  late List<String> labels;
  String predOne = '';
  double confidence = 0;
  double index = 0;
  bool modelLoaded = false;
  late CameraController cameraController;
  bool isDetecting = false;

  Future<bool> saveImageToDevice(XFile imageFile) async {
    try {
      // Get the directory to save the image
      final String dir = (await getApplicationDocumentsDirectory()).path;

      // Create a new file path
      final File newFile = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");

      // Copy the image file to the new path
      await imageFile.saveTo(newFile.path);

      // Optionally, save to the gallery
      final result = await ImageGallerySaver.saveFile(newFile.path);
      return result['isSuccess'] ?? false;
    } catch (e) {
      debugPrint("Error saving image: $e");
      return false;
    }
  }

  Future<void> saveImageData(XFile image) async {
    final result = await saveImageToDevice(image);
    if (result) {
      showToast("그림이 갤러리에 저장되었습니다!");
    } else {
      showToast("그림 저장이 실패했어요:(", backgroundColor: AppColors.error);
    }
  }

  CameraImage preprocessImage(CameraImage image) {
    ///TODO
    return image;
  }

  List processOutput(List<dynamic> output) {
    //TODO
    return output;
  }

  Future<Object> runInference(CameraImage image) async {
    if (interpreter == null || !isDetecting) return "";

    isDetecting = true;

    // Convert CameraImage to input format for the model
    // This often involves converting YUV to RGB, resizing, and normalizing

    // Example pseudo-code for inference
    var input = preprocessImage(image); // Implement this based on your model needs
    // Assuming your model outputs a 1D tensor with 3 elements for the batch size of 1
    var output = List.filled(3, 0).reshape([1, 3]); // Adjusted for 3 output values

    interpreter.run(input, output);

    // Process the model output
    final recognitionResults = processOutput(output); // Implement based on your model

    isDetecting = false;

    return recognitionResults;
  }

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

    cameraController = CameraController(widget.camera, ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      cameraController.startImageStream((image) async {
        if (!isDetecting) {
          final value = await runInference(image);
          setRecognitions(value);
        }
      });
    });
  }

  loadTfliteModel() async {
    interpreter = await Interpreter.fromAsset('assets/tflite/model_unquant.tflite');
    String data = await rootBundle.loadString('assets/tflite/labels.txt');
    labels = data.split('\n');
    print("----------------------- Model loaded successfully");
  }


  setRecognitions(outputs) {
    if (outputs != "") {
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
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }

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
            // Positioned(
            //   top: MediaQuery.of(context).size.height * 0.1,
            //   left: MediaQuery.of(context).size.width * 0.05,
            //   width: MediaQuery.of(context).size.width * 0.3,
            //   height: MediaQuery.of(context).size.width * 0.3,
            //   child: Image.asset("assets/images/test_img.png"),
            // ),
            // Positioned(
            //     top: MediaQuery.of(context).size.height * 0.65,
            //     left: MediaQuery.of(context).size.width * 0.05,
            //     width: MediaQuery.of(context).size.width * 0.3,
            //     height: MediaQuery.of(context).size.width * 0.3,
            //     child: const Text(
            //       "이 도끼가 당신의 도끼인가요?",
            //       textAlign: TextAlign.center,
            //     )),
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
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: cameraController.value.previewSize!.width,
                                    height: cameraController.value.previewSize!.height,
                                    child: CameraPreview(cameraController),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
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
