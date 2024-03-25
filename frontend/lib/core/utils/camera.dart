import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
