import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpressionCamera extends StatefulWidget {
  const ExpressionCamera({super.key});

  @override
  State<ExpressionCamera> createState() => _ExpressionCameraState();
}

class _ExpressionCameraState extends State<ExpressionCamera> {
  late CameraDescription camera;
  late CameraController cameraController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      camera = Provider.of<CameraDescription>(context, listen: false);
      cameraController = CameraController(camera, ResolutionPreset.medium);

      await cameraController.initialize();

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : SizedBox(
            width: cameraController.value.previewSize!.width,
            height: cameraController.value.previewSize!.height,
            child: CameraPreview(cameraController),
          );
  }
}
