import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

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
import 'package:image/image.dart' as imglib;

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

  Future<imglib.Image?> convertYUV420toRGBImage(CameraImage cameraImage) async {
    try {
      final imageWidth = cameraImage.width;
      final imageHeight = cameraImage.height;

      final yBuffer = cameraImage.planes[0].bytes;
      final uBuffer = cameraImage.planes[1].bytes;
      final vBuffer = cameraImage.planes[2].bytes;

      final int yRowStride = cameraImage.planes[0].bytesPerRow;
      final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

      final int uvRowStride = cameraImage.planes[1].bytesPerRow;
      final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

      final image = imglib.Image(imageWidth, imageHeight);

      for (int h = 0; h < imageHeight; h++) {
        int uvh = (h / 2).floor();

        for (int w = 0; w < imageWidth; w++) {
          int uvw = (w / 2).floor();

          final yIndex = (h * yRowStride) + (w * yPixelStride);

          final int y = yBuffer[yIndex];

          final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

          final int u = uBuffer[uvIndex];
          final int v = vBuffer[uvIndex];

          int r = (y + v * 1436 / 1024 - 179).round();
          int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
          int b = (y + u * 1814 / 1024 - 227).round();

          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          final int argbIndex = h * imageWidth + w;

          image.data[argbIndex] = 0xff000000 | ((b << 16) & 0xff0000) | ((g << 8) & 0xff00) | (r & 0xff);
        }
      }

      return image;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  List<dynamic> normalizeImagePixels(imglib.Image image) {
    var normalizedPixels = Float32List(image.width * image.height * 3);
    int pixelIndex = 0;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        var pixel = image.getPixel(x, y);
        normalizedPixels[pixelIndex++] = (imglib.getRed(pixel) / 255.0);
        normalizedPixels[pixelIndex++] = (imglib.getGreen(pixel) / 255.0);
        normalizedPixels[pixelIndex++] = (imglib.getBlue(pixel) / 255.0);
      }
    }

    var changedInput = normalizedPixels.reshape([1, 224, 224, 3]);

    return changedInput;
  }

  Future<List> preprocessImage(CameraImage image) async {
    imglib.Image? rgbImage = await convertYUV420toRGBImage(image);
    if (rgbImage == null) {
      throw Exception("Failed to convert CameraImage to RGB.");
    }

    // Determine the side length for the square crop (use the min dimension of the image)
    int cropSize = min(rgbImage.width, rgbImage.height);

    // Calculate the top left corner of the square crop (to crop from the center)
    int offsetX = (rgbImage.width - cropSize) ~/ 2;
    int offsetY = (rgbImage.height - cropSize) ~/ 2;

    // Crop the image
    imglib.Image croppedImage = imglib.copyCrop(rgbImage, offsetX, offsetY, cropSize, cropSize);

    // Resize the cropped image to the desired size
    imglib.Image resizedImage = imglib.copyResize(croppedImage, width: 224, height: 224);


    List<dynamic> normalizedImage = normalizeImagePixels(resizedImage);

    return normalizedImage;
  }

  Future<List> runInference(CameraImage image) async {
    var input = await preprocessImage(image); // Implement this based on your model needs
    var outputShape = interpreter.getOutputTensor(0).shape;
    var output = List.filled(outputShape[1], 0).reshape([1, outputShape[1]]);
    interpreter.run(input, output);
    return output;
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

      int frameCounter = 0;
      int frameProcessingInterval = 5; // Adjust based on performance

      cameraController.startImageStream((CameraImage image) async {
        frameCounter++;
        if (frameCounter % frameProcessingInterval == 0 && !isDetecting) {
          isDetecting = true;
          try {
            final value = await runInference(image);
            setRecognitions(value);
          } finally {
            isDetecting = false;
          }
        }
      });

    });
  }

  loadTfliteModel() async {
    interpreter = await Interpreter.fromAsset('assets/tflite/model_unquant.tflite');
    String data = await rootBundle.loadString('assets/tflite/labels.txt');
    labels = data.split('\n');
  }

  // Assuming 'savingResult' is a member variable of your state class to persist across frames
  List<String> savingResult = [];

  void setRecognitions(List<dynamic> outputs) {
    if (outputs.isNotEmpty) {
      // Assuming outputs[0] is a List<double> of probabilities and that you want the index with the highest probability
      List<double> probabilities = outputs[0].cast<double>();
      double maxValue = probabilities.reduce(max);
      int maxIndex = probabilities.indexOf(maxValue);
      String prediction = labels[maxIndex]; // Assuming 'labels' is a list of string labels

      // Check if the prediction is not actionable
      if (prediction == "N/A") {
        savingResult.clear();
      } else {
        // Check if there's a consistency in prediction or it's the first time
        if (savingResult.isEmpty || savingResult.last == prediction) {
          savingResult.add(prediction);
        } else {
          // If the current prediction differs from the last, reset
          savingResult.clear();
          savingResult.add(prediction); // Optionally start accumulating again with the new prediction
        }
      }

      // Act on accumulated results if conditions are met
      if (savingResult.length == 5) {
        // Perform any action with the consistent prediction
        setState(() {
          predOne = savingResult.first; // Assuming you want to show the consistently predicted label
        });

        savingResult.clear(); // Reset for next set of predictions
      }
    }
  }
  @override
  void dispose() {
    cameraController.dispose();
    // interpreter.close();
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
