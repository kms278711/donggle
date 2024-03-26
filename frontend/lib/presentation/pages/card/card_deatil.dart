import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/component/icons/circle_back_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_cards.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;

class CardDetail extends StatefulWidget {
  int educationId;

  CardDetail(this.educationId, {super.key});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  late CardModel cardModel;
  String wordName = "";
  String imagePath = "";
  String bookTitle = "";
  String bookSentence = "";
  List userImages = [];
  String url = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadDataAsync();
    });
  }

  Future loadDataAsync() async {
    var cardModel = Provider.of<domain.CardModel>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var accessToken = userProvider.getAccessToken();

    await cardModel.getSelectedCard(accessToken, widget.educationId);
    // 데이터 로딩 완료 후 상태 업데이트
    setState(() {
      wordName = cardModel.selectedCard['wordName'];
      imagePath = cardModel.selectedCard['imagePath'];
      bookTitle = cardModel.selectedCard['bookTitle'];
      bookSentence = cardModel.selectedCard['bookSentence'];
      userImages = cardModel.selectedCard['userImages'];
      url = Constant.s3BaseUrl + imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.textMediumLarge,
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
                child: Image.asset(AppIcons.bottle,
                    width: MediaQuery.of(context).size.width * 0.35),
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
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.13,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.25,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.115,
            right: MediaQuery.of(context).size.width * 0.06,
            child: GreenButton("학습하기", onPressed: () {
              // 캔버스 띄우기
            }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
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
            child: Container(
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
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.39,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내가 그린 그림',
                    style: CustomFontStyle.textSmall,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: userImages.map((imagePath) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                            child: CachedNetworkImage(
                              imageUrl: Constant.s3BaseUrl + imagePath,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.14,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
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
}
