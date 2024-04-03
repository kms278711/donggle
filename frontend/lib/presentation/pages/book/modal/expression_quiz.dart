import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/add_post_position_text.dart';
import 'package:frontend/core/utils/camera_image_processing.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/effect_sound.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/data/data_source/remote/emotion.api.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ExpressionQuiz extends StatefulWidget {
  final VoidCallback? onModalClose;

  const ExpressionQuiz({this.onModalClose, super.key});

  @override
  State<ExpressionQuiz> createState() => _ExpressionQuizState();
}

class _ExpressionQuizState extends State<ExpressionQuiz> {
  late BookModel bookModel;
  late UserProvider userProvider;
  late CameraController cameraController;

  Education education = Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
  bool _isLoading = true;
  String url = "";
  String educationWord = "";
  String apiResult = "";
  String accessToken = "";
  String number = "";

  @override
  void initState() {
    super.initState();
    player.pause();

    effectPlaySound("assets/music/question_start.mp3", 1);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      final firstCamera = cameras.last;

      if (mounted) {
        bookModel = Provider.of<BookModel>(context, listen: false);
        userProvider = Provider.of<UserProvider>(context, listen: false);
        accessToken = userProvider.getAccessToken();

        cameraController = CameraController(firstCamera, ResolutionPreset.medium);
        education = bookModel.nowEducation;

        await cameraController.initialize();

        if (mounted) {
          setState(() {
            String path = bookModel.nowEducation.imagePath;
            url = Constant.s3BaseUrl + path;
            educationWord = bookModel.nowEducation.wordName;

            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  String extractFileNameWithoutExtension(String url) {
    // Split the URL by '/'
    List<String> parts = url.split('/');
    // Take the last part, which should be 'axe.png' in your example
    String fileNameWithExtension = parts.last;
    // Split by '.' and take the first part to remove the extension
    String fileName = fileNameWithExtension.split('.').first;
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    // Build method now only contains UI code
    Widget resultWidget;
    if (apiResult == "true") {
      resultWidget = Image.asset("assets/images/correct.png");
    } else if (apiResult == "false") {
      resultWidget = Image.asset("assets/images/incorrect.png");
    } else {
      // Placeholder or empty container when there's no result or an error
      resultWidget = Container();
    }

    return DefaultTextStyle(
      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMedium),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(217, 217, 217, 0.9),
        ),
        child: _isLoading
            ? Stack(
                children: [
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
                ],
              )
            : Stack(
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
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        "${postPositionText(educationWord)} 따라해보세요.",
                        textAlign: TextAlign.center,
                      )),
                  Stack(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.height * 0.03,
                    child: GreenButton(
                      "촬영하기",
                      onPressed: () async {
                        effectPlaySound("assets/music/photo_ready.mp3", 1);
                        setState(() {
                          number = "3";
                        });
                        Timer(const Duration(seconds: 1), () {
                          effectPlaySound("assets/music/photo_ready.mp3", 1);
                          setState(() {
                            number = "2";
                          });
                          Timer(const Duration(seconds: 1), () {
                            effectPlaySound("assets/music/photo_ready.mp3", 1);
                            setState(() {
                              number = "1";
                            });
                            Timer(const Duration(seconds: 1), () async{
                              effectPlaySound("assets/music/take_photo.mp3", 1);
                              setState(() {
                                number = "";
                              });
                              final image = await cameraController.takePicture();
                              String fileName = extractFileNameWithoutExtension(education.imagePath);
                              var img = await CameraImageProcessing.getImageData(image);
                              EmotionApi emotionApi = EmotionApi(file: img, filename: fileName);
                              // await CameraImageProcessing.saveImageData(img);

                              String result = await emotionApi.emotionAI();

                              if (!context.mounted) return;

                              setState(() {
                                apiResult = result; // Update state with the API call result
                              });

                              if (result != "true" && result != "false") {
                                showToast("다시 시도해주세요.", backgroundColor: AppColors.error);
                              }

                              if (result == "true") {
                                effectPlaySound("assets/music/answer.mp3", 1);
                                await bookModel.saveEducationImage(accessToken, education.educationId, img);
                              } else {
                                effectPlaySound("assets/music/wrong.mp3", 1);
                              }

                              Timer(const Duration(milliseconds: 1000), () {
                                if (!context.mounted) return; // Always check mounted status before calling setState
                                setState(() {
                                  apiResult = ""; // Reset apiResult to hide the sign
                                });

                                if (result == "true") {
                                  Navigator.of(context).pop();
                                  widget.onModalClose?.call();
                                }
                              });
                            });
                          });
                        });




                      },
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.16,
                    top: MediaQuery.of(context).size.height * 0.21,
                    child: Text(
                      number,
                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.huge),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.015,
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
                      child: SizedBox(height: MediaQuery.of(context).size.height, child: resultWidget),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
