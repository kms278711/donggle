import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/component/icons/circle_back_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_cards.dart';
import 'package:frontend/presentation/pages/book/modal/expression_quiz.dart';
import 'package:frontend/presentation/pages/book/modal/picture_quiz.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;
import 'package:widgets_to_image/widgets_to_image.dart';

class CardDetail extends StatefulWidget {
  final int educationId;

  const CardDetail(this.educationId, {super.key});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  // WidgetsToImageController to access widget

// to save image bytes of widget
  Uint8List? bytes;

  late CardModel cardModel;
  late BookModel bookModel;
  late UserProvider userProvider;
  late Directory documentDirectory;
  String wordName = "";
  String imagePath = "";
  String bookTitle = "";
  String bookSentence = "";
  List userImages = [];
  String category = "";
  String accessToken = "";
  String traceImagePath = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadDataAsync();
    });
  }

  Future loadDataAsync() async {
    cardModel = Provider.of<domain.CardModel>(context, listen: false);
    bookModel = Provider.of<BookModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();

    await cardModel.getSelectedCard(accessToken, widget.educationId);
    // 데이터 로딩 완료 후 상태 업데이트
    documentDirectory = await getApplicationDocumentsDirectory();

    setState(() {
      wordName = cardModel.selectedCard['wordName'];
      imagePath = cardModel.selectedCard['imagePath'];
      bookTitle = cardModel.selectedCard['bookTitle'];
      bookSentence = cardModel.selectedCard['bookSentence'];
      userImages = cardModel.selectedCard['userImages'];
      category = cardModel.selectedCard['category'];
      bookModel.nowEducation =
          Education(educationId: widget.educationId, wordName: wordName, imagePath: imagePath, category: category);
      if (category == "PICTURE") {
        bookModel.nowEducation.traceImagePath = cardModel.selectedCard['traceImagePath'];
      }
      _isLoading = false;
    });
  }

  Future<bool> saveImageToDevice() async {
    try {
      // Using image_gallery_saver
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
      await file.writeAsBytes(bytes!);
      final result = await ImageGallerySaver.saveFile(file.path);
      return result['isSuccess'];
    } catch (e) {
      debugPrint("Error saving image: $e");
      return false;
    }
  }

  Future<void> saveImageData() async {
    if (bytes == null) {
      showToast('오류가 났어요:(', backgroundColor: AppColors.error);
      return;
    }
    if (!context.mounted) return;
    if (mounted) {
      final result = await saveImageToDevice();
      if (result) {
        showToast("그림이 갤러리에 저장되었습니다!");
      } else {
        showToast("그림 저장이 실패했어요:(", backgroundColor: AppColors.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMediumLarge),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Image.asset(
                AppIcons.parchment,
                height: MediaQuery.of(context).size.height * 0.88,
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            top: 0,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.bottle, width: MediaQuery.of(context).size.width * 0.35),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.32,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.25,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wordName,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.115,
            left: MediaQuery.of(context).size.width * 0.045,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleBackIcon(
                size: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.22,
            left: MediaQuery.of(context).size.width * 0.09,
            child: Container(
              color: Colors.transparent,
              child: Transform.rotate(
                angle: 356 * pi / 180,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _isLoading
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: const Center(child: CircularProgressIndicator()))
                          : Image.file(
                              File('${documentDirectory.path}/$imagePath'),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        color: Colors.transparent,
                        child: Text(
                          wordName,
                          textAlign: TextAlign.center,
                          style: CustomFontStyle.textLarge,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.115,
            right: MediaQuery.of(context).size.width * 0.06,
            child: GreenButton("학습하기", onPressed: () {
              // 캔버스 띄우기
              if (category == "PICTURE") {
                DialogUtils.showCustomDialog(context, contentWidget: PictureQuiz(
                  onModalClose: () async {
                    await cardModel.getSelectedCard(accessToken, widget.educationId);
                    setState(() {
                      userImages = cardModel.selectedCard['userImages'];
                    });
                  },
                ));
              } else if (category == "EXPRESSION") {
                DialogUtils.showCustomDialog(context, contentWidget: ExpressionQuiz(
                  onModalClose: () async {
                    await cardModel.getSelectedCard(accessToken, widget.educationId);
                    setState(() {
                      userImages = cardModel.selectedCard['userImages'];
                    });
                  },
                ));
              }
            }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: MediaQuery.of(context).size.width * 0.1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.15,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '동화',
                    style: CustomFontStyle.textSmall,
                  ),
                  Text(
                    bookTitle,
                    style: CustomFontStyle.textMedium,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.15,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '문장',
                    style: CustomFontStyle.textSmall,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        bookSentence,
                        style: CustomFontStyle.textMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            right: MediaQuery.of(context).size.width * 0.1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.39,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 학습',
                    style: CustomFontStyle.textSmall,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: userImages.map((imagePath) {
                          WidgetsToImageController controller = WidgetsToImageController();
                          return WidgetsToImage(controller: controller, child: cardWidget(imagePath, controller));
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: donggleTalk(situation: "WORD"),
          ),
        ],
      ),
    );
  }

  Widget cardWidget(String imagePath, WidgetsToImageController controller) {
    return GestureDetector(
      onTap: () async {
        final bytes = await controller.capture();
        setState(() {
          this.bytes = bytes;
        });
        await saveImageData();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/card.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.15,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.025, left: MediaQuery.of(context).size.width * 0.018),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: Constant.s3BaseUrl + imagePath,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.17,
                // width: MediaQuery.of(context).size.width * 0.14,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
