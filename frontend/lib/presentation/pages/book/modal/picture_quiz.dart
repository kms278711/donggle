import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
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
  final DrawingController _drawingController = DrawingController();
  Education education = Education(educationId: 0, gubun: "", wordName: "", imagePath: "", bookSentenceId: 0);
  String url = "";

  String postPositionText(String name) {
    // Get the last character of the name
    final String? lastText = name.isNotEmpty ? name.characters.last : null;

    if (lastText == null) {
      return name;
    }
    // Convert to Unicode
    final int unicodeVal = lastText.runes.first;
    // Return the name if it's not a Hangul syllable
    if (unicodeVal < 0xAC00 || unicodeVal > 0xD7A3) {
      return name;
    }
    // Check if there's a final consonant
    final int last = (unicodeVal - 0xAC00) % 28;
    // Append '을' if there is a final consonant, otherwise '를'
    final String str = last > 0 ? "을" : "를";
    return name + str;
  }

  @override
  void initState() {
    super.initState();

      bookModel = Provider.of<BookModel>(context, listen: false);
      education = bookModel.nowEducation;
      url = Constant.s3BaseUrl + education.imagePath;
  }

  @override
  void dispose() {
    _drawingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    Future<void> getImageData() async {
      final Uint8List? data = (await _drawingController.getImageData())?.buffer.asUint8List();
      if (data == null) {
        debugPrint('获取图片数据失败');
        return;
      }
      if (!context.mounted) return;
      if (mounted) {
        final result = await saveImageToDevice(data);
        if (result) {
          showToast("Image saved to device!");
        } else {
          showToast("Failed to save image");
        }
      }
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
              right: MediaQuery.of(context).size.width * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.03,
              child: GreenButton(
                "완료",
                onPressed: () {
                  Navigator.of(context).pop();
                  getImageData();
                  widget.onModalClose?.call();
                },
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
