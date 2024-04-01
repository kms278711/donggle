import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/effect_sound.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imglib;

class NowordQuiz extends StatefulWidget {
  final VoidCallback? onModalClose;

  const NowordQuiz({this.onModalClose, super.key});

  @override
  State<NowordQuiz> createState() => _NowordQuizState();
}

class _NowordQuizState extends State<NowordQuiz> {
  late Interpreter interpreter;
  late List<String> labels;
  String predOne = '';
  double confidence = 0;
  double index = 0;
  bool modelLoaded = false;
  late CameraController cameraController;
  bool isDetecting = false;
  late BookModel bookModel;
  Education education = Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
  bool _isLoading = true;
  String DBResult = "";
  String educationWord = "";
  int correct = 3;
  bool _isTimerDone = true;
  String url = "";

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
      debugPrint(">>>>>>>>>>>> ERROR:$e");
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

  Widget resultWidget() {
    if (correct == 3) {
      return Container();
    } else if (correct == 1) {
      return Image.asset("assets/images/correct.png");
    } else {
      return Image.asset("assets/images/incorrect.png");
    }
  }

  @override
  void initState() {
    super.initState();
    player.pause();

    effectPlaySound("assets/music/question_start.mp3", 1);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      final firstCamera = cameras.last;
      cameraController = CameraController(firstCamera, ResolutionPreset.medium);

      if (mounted) {
        bookModel = Provider.of<BookModel>(context, listen: false);
        education = bookModel.nowEducation;
        loadTfliteModel().then((_) {
          if (mounted) {
            setState(() {
              modelLoaded = true;
            });
          }
        });

        cameraController.initialize().then((value) {
          setState(() {
            DBResult = bookModel.nowEducation.imagePath;
            educationWord = bookModel.nowEducation.wordName;
            String path = bookModel.nowEducation.traceImagePath ?? "";
            url = Constant.s3BaseUrl + path;

            _isLoading = false;
          });

          Timer(const Duration(seconds: 3), (){
            int frameCounter = 0;
            int frameProcessingInterval = 8; // Adjust based on performance

            cameraController.startImageStream((CameraImage image) async {
              frameCounter++;
              if (frameCounter % frameProcessingInterval == 0 && !isDetecting && _isTimerDone) {
                isDetecting = true;

                final value = await runInference(image);
                await setRecognitions(value);

                isDetecting = false;
              }
            });

          });


        });
      }
    });
  }

  loadTfliteModel() async {
    interpreter = await Interpreter.fromAsset('assets/tflite/model_unquant.tflite');
    String data = await rootBundle.loadString('assets/tflite/labels.txt');
    labels = data.split('\n');
  }

  // Assuming 'savingResult' is a member variable of your state class to persist across frames
  List<String> savingResult = [];

  Future<void> setRecognitions(List<dynamic> outputs) async {
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
      if (savingResult.length >= 5) {
        // Perform any action with the consistent prediction

        String consistentPrediction = savingResult.last;
        await processPrediction(consistentPrediction);
        savingResult.clear(); // Reset for next set of predictions
      }
    }
  }

  Future<void> processPrediction(String prediction) async {
    String trimmedPrediction = prediction.trim();

    if (trimmedPrediction.isNotEmpty && trimmedPrediction != "N/A") {
      setState(() {
        predOne = trimmedPrediction;
        correct = trimmedPrediction == DBResult ? 1 : 0;
        _isTimerDone = false;
      });

      // Play sound based on the result
      String soundPath = correct == 1 ? "assets/music/answer.mp3" : "assets/music/wrong.mp3";
      effectPlaySound(soundPath, 1);

      // Wait for 1 second before executing the next action
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;

        // Optionally navigate away or call the modal close callback
        if (correct == 1) {
          Navigator.of(context).pop();
          widget.onModalClose?.call();
        } else {
          setState(() {
            correct = 3; // Reset the state to hide the result widget
            _isTimerDone = true;
          });
        }
      });
    } else {
      setState(() {
        predOne = trimmedPrediction;
        _isTimerDone = true;
      });
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
            modelLoaded && !_isLoading
                ? Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.1,
                        left: MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.65,
                          left: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            educationWord,
                            textAlign: TextAlign.center,
                          )),
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
                            // Text(
                            //   "Prediction: $predOne",
                            //   style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmallEng),
                            // ),
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
                  widget.onModalClose?.call();
                },
              ),
            ),
            Positioned(
              // Add the result widget to your UI
              child: Center(
                child: SizedBox(height: MediaQuery.of(context).size.height, child: resultWidget()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
