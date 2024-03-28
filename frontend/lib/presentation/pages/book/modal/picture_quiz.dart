import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/add_post_position_text.dart';
import 'package:frontend/core/utils/component/effect_sound.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/data/data_source/remote/drawing.api.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/drawing_board/flutter_drawing_board.dart';
import 'package:frontend/core/drawing_board/paint_extension.dart';
import 'package:frontend/core/drawing_board/src/paint_contents/paint_content.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PictureQuiz extends StatefulWidget {
  final VoidCallback? onModalClose;

  const PictureQuiz({this.onModalClose, super.key});

  @override
  State<PictureQuiz> createState() => _PictureQuizState();
}

class _PictureQuizState extends State<PictureQuiz> {
  late BookModel bookModel;
  late UserProvider userProvider;
  final DrawingController _drawingController = DrawingController();
  Education education = Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
  String url = "";
  String accessToken = "";
  String? apiResult;

  @override
  void initState() {
    super.initState();

    effectPlaySound("assets/music/question_start.mp3", 1);

    bookModel = Provider.of<BookModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    education = bookModel.nowEducation;
    String path = education.traceImagePath ?? "";
    url = Constant.s3BaseUrl + path;

  }

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget resultWidget;
    if (apiResult == "true") {
      resultWidget = Image.asset("assets/images/correct.png");
    } else if (apiResult == "false") {
      resultWidget = Image.asset("assets/images/incorrect.png");
    } else {
      // Placeholder or empty container when there's no result or an error
      resultWidget = Container();
    }

    Future<Uint8List> resizeImageData(Uint8List data, {int width = 600, int height = 600}) async {
      // Decode the image to an Image object
      img.Image? image = img.decodeImage(data);
      if (image == null) return data;

      // Resize the image using the image package
      img.Image resized = img.copyResize(image, width: width, height: height);

      // Encode the resized image back to Uint8List
      return Uint8List.fromList(img.encodePng(resized));
    }

    Future<bool> saveImageToDevice(Uint8List data) async {
      try {
        final resizedImg = await resizeImageData(data);
        // Using image_gallery_saver
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
        await file.writeAsBytes(resizedImg);
        final result = await ImageGallerySaver.saveFile(file.path);
        return result['isSuccess'];
      } catch (e) {
        debugPrint("Error saving image: $e");
        return false;
      }
    }

    Future<void> saveImageData() async {
      final Uint8List? data = (await _drawingController.getImageData())?.buffer.asUint8List();
      if (data == null) {
        showToast('오류가 났어요:(', backgroundColor: AppColors.error);
        return;
      }
      if (!context.mounted) return;
      if (mounted) {
        final result = await saveImageToDevice(data);
        if (result) {
          showToast("그림이 갤러리에 저장되었습니다!");
        } else {
          showToast("그림 저장이 실패했어요:(", backgroundColor: AppColors.error);
        }
      }
    }

    Future<Uint8List> addWhiteBackground(Uint8List imageData) async {
      // Decode the image from the data
      img.Image? originalImage = img.decodeImage(imageData);
      if (originalImage == null) return imageData;

      // Create a new image with a white background
      img.Image newImage = img.Image(originalImage.width, originalImage.height, channels: img.Channels.rgba);
      img.fill(newImage, img.getColor(255, 255, 255, 255)); // Fill the image with white color

      // Draw the original image onto the new image
      img.drawImage(newImage, originalImage);

      // Encode the new image back to Uint8List
      Uint8List newData = Uint8List.fromList(img.encodePng(newImage));
      return newData;
    }

    Future<File> getWhiteImageData() async {
      final Uint8List? data = (await _drawingController.getImageData())?.buffer.asUint8List();
      if (data == null) {
        debugPrint('Failed to get image data');
        throw Exception('Failed to get image data'); // Throw an exception or handle the error as needed
      }

      Uint8List newData = await addWhiteBackground(data);

      // Get a temporary directory (you can choose a different directory if you like)
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';

      // Write the image data to a file
      final File file = File(filePath);
      await file.writeAsBytes(newData);

      return file;
    }

    Future<File> getImageData() async {
      final Uint8List? data = (await _drawingController.getImageData())?.buffer.asUint8List();
      if (data == null) {
        debugPrint('Failed to get image data');
        throw Exception('Failed to get image data'); // Throw an exception or handle the error as needed
      }


      // Get a temporary directory (you can choose a different directory if you like)
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';

      // Write the image data to a file
      final File file = File(filePath);
      await file.writeAsBytes(data);

      return file;
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
              top: MediaQuery.of(context).size.height * 0.1315,
              left: MediaQuery.of(context).size.width * 0.235,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.width * 0.43,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(url),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1315,
              left: MediaQuery.of(context).size.width * 0.235,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.width * 0.43,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryContainer,
                    // Assume AppColors is defined elsewhere
                    width: 10.0,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${postPositionText(education.wordName)} 그려보세요.",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.43, // Or another appropriate size
                      height: MediaQuery.of(context).size.width * 0.43, // Ensure aspect ratio or size as needed
                      child: DrawingBoard(
                          showDefaultActions: true,
                          showDefaultTools: true,
                          controller: _drawingController,
                          background: Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.width * 0.43,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
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
              right: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.03,
              child: Row(
                children: [
                  GreenButton("저장", onPressed: () {
                    saveImageData();
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  GreenButton(
                    "완료",
                    onPressed: () async {
                      String fileName = extractFileNameWithoutExtension(education.imagePath);
                      DrawingApi drawingApi = DrawingApi(file: await getWhiteImageData(), filename: fileName);

                      String result = await drawingApi.drawingAI();

                      if (!context.mounted) return;

                      setState(() {
                        apiResult = result; // Update state with the API call result
                      });

                      if (result != "true" && result != "false") {
                        showToast(result, backgroundColor: AppColors.error);
                      }

                      if(result == "true"){
                        effectPlaySound("assets/music/answer.mp3", 1);
                        await bookModel.saveEducationImage(accessToken, education.educationId, await getImageData());
                      }else{
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
                    },
                  ),
                ],
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

class ImageContent extends PaintContent {
  ImageContent(this.image, {this.imageUrl = ''});

  ImageContent.data({
    required this.startPoint,
    required this.size,
    required this.image,
    required this.imageUrl,
    required Paint paint,
  }) : super.paint(paint);

  factory ImageContent.fromJson(Map<String, dynamic> data) {
    return ImageContent.data(
      startPoint: jsonToOffset(data['startPoint'] as Map<String, dynamic>),
      size: jsonToOffset(data['size'] as Map<String, dynamic>),
      imageUrl: data['imageUrl'] as String,
      image: data['image'] as ui.Image,
      paint: jsonToPaint(data['paint'] as Map<String, dynamic>),
    );
  }

  Offset startPoint = Offset.zero;
  Offset size = Offset.zero;
  final String imageUrl;
  final ui.Image image;

  @override
  void startDraw(Offset startPoint) => this.startPoint = startPoint;

  @override
  void drawing(Offset nowPoint) => size = nowPoint - startPoint;

  @override
  void draw(Canvas canvas, Size size, bool deeper) {
    final Rect rect = Rect.fromPoints(startPoint, startPoint + this.size);
    paintImage(canvas: canvas, rect: rect, image: image, fit: BoxFit.fill);
  }

  @override
  ImageContent copy() => ImageContent(image);

  @override
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{
      'startPoint': startPoint.toJson(),
      'size': size.toJson(),
      'imageUrl': imageUrl,
      'paint': paint.toJson(),
    };
  }
}
