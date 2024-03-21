import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/image_utils.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:tflite_v2/tflite_v2.dart';

typedef void Callback(List<dynamic> list);

class Camera extends StatefulWidget {
  final CameraDescription camera;
  final Callback setRecognitions;
  // final Interpreter interpreter;

  Camera(this.camera, this.setRecognitions);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController cameraController;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(widget.camera, ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      cameraController.startImageStream((image) async {
        if (!isDetecting) {
          isDetecting = true;

          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            numResults: 1,
          ).then((value) {
            if (value!.isNotEmpty) {
              widget.setRecognitions(value);
              isDetecting = false;
            }
          });

          // try {
          //   List<String> labels = await FileUtil.loadLabels("assets/tflite/labels.txt");
          //   Uint8List inputImage = await ImageUtils.preprocessCameraImage(image);
          //
          //   // Create an output buffer with the shape [1, 3]
          //   List<List<int>> outputBuffer = List.generate(1, (index) => List.filled(3, 0, growable: false), growable: false);
          //
          //   // Run the interpreter using the input tensor
          //   widget.interpreter.run(inputImage, outputBuffer);
          //
          //   // Assuming the model output is quantized, dequantize the output
          //   double scale = 0.00390625; // The scale from your model's quantization parameters
          //   int zeroPoint = 128;       // The zero-point from your model's quantization parameters
          //
          //   List<double> dequantizedOutput = outputBuffer[0].map<double>((val) {
          //     int intValue = val; // Ensure val is treated as int
          //     double dequantizedValue = (intValue - zeroPoint) * scale; // Explicitly perform arithmetic as double
          //     return dequantizedValue;
          //   }).toList();
          //
          //   // Find the index of the maximum score after dequantization
          //   int highestScoreIndex = dequantizedOutput.indexWhere((double val) => val == dequantizedOutput.reduce(max));
          //
          //   // Explicitly declare the type for confidence.
          //   double confidence = dequantizedOutput.reduce(max);
          //
          //   // Use the index to get the label
          //   String label = labels[highestScoreIndex];
          //
          //   // Now create a recognitions map to pass to the widget.setRecognitions method
          //   List<Map<String, dynamic>> recognitions = [{
          //     'index': 0,
          //     'label': label,
          //     'confidence': confidence,
          //   }];
          //
          //   // Update the UI by calling setRecognitions with the processed output
          //   widget.setRecognitions(recognitions);
          // } catch (e) {
          //   print("Error running model: $e");
          // } finally {
          //   isDetecting = false;
          // }
        }
      });
    });
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

    return SizedBox(
      width: cameraController.value.previewSize!.width,
      height: cameraController.value.previewSize!.height,
      child: CameraPreview(cameraController),
    );
  }
}
