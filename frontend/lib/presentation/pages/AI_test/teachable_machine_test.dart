import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class TeachableMachineTest extends StatefulWidget {
  const TeachableMachineTest({super.key});

  @override
  State<TeachableMachineTest> createState() => _TeachableMachineTestState();
}

class _TeachableMachineTestState extends State<TeachableMachineTest> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late tfl.Interpreter interpreter;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Move the initialization code here
    final camera = Provider.of<CameraDescription>(context, listen: false); // Use listen: false here
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset('assets/tflite/model.tflite');
  }

  @override
  void dispose() {
    // Ensure the controller is disposed when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              right: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Camera preview
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                              width: _controller.value.previewSize!.width,
                              height: _controller.value.previewSize!.height,
                              child: CameraPreview(_controller))),
                    );
                  } else {
                    // Loading indicator
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
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
