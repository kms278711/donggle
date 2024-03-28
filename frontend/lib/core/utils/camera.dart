import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_v2/tflite_v2.dart';

typedef void Callback(List<dynamic> list);

class Camera extends StatefulWidget {
  final CameraDescription camera;
  final Callback setRecognitions;

  // final Interpreter interpreter;

  const Camera(this.camera, this.setRecognitions, {super.key});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
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
          ).then((value) async {
            if (value!.isNotEmpty) {
              widget.setRecognitions(value);
              final image = await cameraController.takePicture();
              saveImageData(image);
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
