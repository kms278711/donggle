import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_donggle_talk.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class donggleTalk extends StatefulWidget {
  final String situation;

  const donggleTalk({super.key, required this.situation});

  @override
  State<donggleTalk> createState() => _donggleTalkState();
}

class _donggleTalkState extends State<donggleTalk> {
  late DonggleTalkModel donggleTalkModel;
  String donggleTalk = "";
  bool touched_donggle = false;

  void setTouchedDonggle() {
    setState(() {
      touched_donggle = !touched_donggle;
    });
  }

  @override
  void initState() {
    super.initState();
    donggleTalkModel = Provider.of<DonggleTalkModel>(context, listen: false);
    // donggleTalk = donggleTalkModel.dongglesTalk["content"];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: true, // 상위 Container의 터치를 무시
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.transparent,
            child: Stack(
              children: [
                // 이곳에 터치 이벤트를 무시하고 싶은 다른 위젯들을 배치
                touched_donggle
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.width * 0.01,
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Image.asset(
                                AppIcons.donggle_talk_balloon,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                            Positioned(
                              top: widget.situation == 'BOOKLIST'
                                  ? MediaQuery.of(context).size.height * 0.22
                                  : widget.situation == 'BOOK'
                                      ? MediaQuery.of(context).size.height *
                                          0.24
                                      : widget.situation == 'WORDLIST'
                                          ? MediaQuery.of(context).size.height *
                                              0.22
                                          : widget.situation == 'WORD'
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.27
                                              : widget.situation == 'QUIZ'
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.27
                                                  : widget.situation ==
                                                          'QUIZRESULT'
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.27
                                                      : 10,
                              right: widget.situation == 'BOOKLIST'
                                  ? MediaQuery.of(context).size.width * 0.054
                                  : widget.situation == 'BOOK'
                                      ? MediaQuery.of(context).size.width *
                                          0.038
                                      : widget.situation == 'WORDLIST'
                                          ? MediaQuery.of(context).size.width *
                                              0.034
                                          : widget.situation == 'WORD'
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035
                                              : widget.situation == 'QUIZ'
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.024
                                                  : widget.situation ==
                                                          'QUIZRESULT'
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.065
                                                      : 10,
                              child: Container(
                                width: widget.situation == 'BOOKLIST'
                                    ? MediaQuery.of(context).size.width * 0.13
                                    : widget.situation == 'BOOK'
                                        ? MediaQuery.of(context).size.width *
                                            0.16
                                        : widget.situation == 'WORDLIST'
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.16
                                            : widget.situation == 'WORD'
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.17
                                                : widget.situation == 'QUIZ'
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.19
                                                    : widget.situation ==
                                                            'QUIZRESULT'
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.11
                                                        : 10,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    donggleTalk,
                                    style: CustomFontStyle.textMedium,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: false, // 이 Container만 터치 가능하도록 설정
            child: GestureDetector(
              onTap: () async {
                await donggleTalkModel.getDonggleTalk(widget.situation);
                setState(() {
                  donggleTalk = donggleTalkModel.dongglesTalk["content"];
                });
                setTouchedDonggle();
              },
              child: Image.asset(
                AppIcons.donggle,
                width: MediaQuery.of(context).size.width * 0.22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
