import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class FinishQuizPage extends StatefulWidget {
  List selectedAnswer;

  FinishQuizPage(this.selectedAnswer, {super.key});

  @override
  State<FinishQuizPage> createState() => _FinishQuizPageState();
}

class _FinishQuizPageState extends State<FinishQuizPage> {
  bool _isAnyAnswerWrong = true;

  @override
  void initState() {
    super.initState();

    _isAnyAnswerWrong =
        widget.selectedAnswer.any((answer) => answer["answer"] == false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.textMedium,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(217, 217, 217, 0.9),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
              height: MediaQuery.of(context).size.height * 0.48,
              // color: Colors.blue,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.selectedAnswer.length,
                itemBuilder: (context, index) {
                  bool check = widget.selectedAnswer[index]["answer"];
                  String url = widget.selectedAnswer[index]["choiceImagePath"];
                  String name = widget.selectedAnswer[index]["choice"];
                  return Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // color: Colors.red,
                    child: Transform.rotate(
                      angle: index % 3 == 0
                          ? 3 * pi / 180
                          : index % 3 == 1
                              ? 350 * pi / 180
                              : 4 * pi / 180,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: Constant.s3BaseUrl + url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.08,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.215,
                              // color: Colors.blue,
                              child: Text(
                                '$name',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.1,
                            left: MediaQuery.of(context).size.width * 0.03,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: check
                                  ? Image.asset("assets/images/correct.png")
                                  : Image.asset("assets/images/incorrect.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.36,
              bottom: MediaQuery.of(context).size.width * 0.03,
              child: Container(
                color: Colors.transparent,
                child: GreenButton(
                  '참 잘했어요~!',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            _isAnyAnswerWrong ?
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: const donggleTalk(situation: "QUIZRESULT_WRONG"),
            ) :
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 0,
              child: const donggleTalk(situation: "QUIZRESULT_CORRECT"),
            ),
          ],
        ),
      ),
    );
  }
}
