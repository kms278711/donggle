import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_donggle_talk.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

// a (진폭): 진동의 진폭을 정의합니다. 높은 값은 진동을 더 두드러지게 만듭니다.
// w (주파수): 진동의 주파수를 나타냅니다. 높은 값은 빠른 진동을 의미합니다.
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.2,
    this.w = 20,
  });

  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(math.pow(math.e, -t / a) * math.cos(t * w)) + 1;
  }
}

class donggleTalk extends StatefulWidget {
  final String situation;

  const donggleTalk({super.key, required this.situation});

  @override
  State<donggleTalk> createState() => _donggleTalkState();
}

class _donggleTalkState extends State<donggleTalk>
    with SingleTickerProviderStateMixin {
  late DonggleTalkModel donggleTalkModel;
  String donggleTalk = "";
  bool touched_donggle = false;

  void setTouchedDonggle(bool visible) {
    setState(() {
      touched_donggle = !touched_donggle;
    });
    if (visible) {
      // 애니메이션 시작
      controller.forward(from: 0.0);
      // 3초 후에 touched_donggle를 false로 설정하여 이미지를 숨깁니다.
      Future.delayed(Duration(milliseconds: 2400), () {
        setState(() {
          touched_donggle = false;
        });
      });
    }
  }

  late AnimationController controller;
  late Animation<double> anim1;
  late Animation<double> anim2;

  @override
  void initState() {
    super.initState();
    donggleTalkModel = Provider.of<DonggleTalkModel>(context, listen: false);
    controller = AnimationController(
      duration: const Duration(milliseconds: 1900),
      vsync: this,
    );

    // 아까 추가한 스프링 커브
    const springCurve = SpringCurve();

    anim1 = Tween<double>(begin: 0.0, end: -10).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 1.7 / 1.9, curve: springCurve),
    ));
    anim2 = Tween<double>(begin: 0.0, end: 10).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.2 / 1.9, 1, curve: springCurve),
    ));
  }

  AudioPlayer donggleSay = AudioPlayer();

  Future<void> sayDonggle(String path) async {
    try {
      await donggleSay.setUrl(path); // 오디오 파일의 URL을 설정
      await donggleSay.play(); // 오디오 재생 시작
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    donggleSay.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: true, // 상위 Container의 터치를 무시
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            color: Colors.transparent,
            child: Stack(
              children: [
                // 이곳에 터치 이벤트를 무시하고 싶은 다른 위젯들을 배치
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.01,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: (anim1.value + anim2.value) * math.pi / 180,
                        child: touched_donggle
                            ? Stack(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Image.asset(
                                AppIcons.donggle_talk_balloon,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.3,
                              ),
                            ),
                            Positioned(
                              top: widget.situation == 'BOOKLIST'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.22
                                  : widget.situation == 'BOOK'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.24
                                  : widget.situation == 'WORDLIST'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.22
                                  : widget.situation == 'WORD'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.27
                                  : widget.situation == 'QUIZ'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.27
                                  : widget.situation ==
                                  'QUIZRESULT'
                                  ? MediaQuery
                                  .of(
                                  context)
                                  .size
                                  .height *
                                  0.27
                                  : 10,
                              right: widget.situation == 'BOOKLIST'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.054
                                  : widget.situation == 'BOOK'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.038
                                  : widget.situation == 'WORDLIST'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.034
                                  : widget.situation == 'WORD'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.035
                                  : widget.situation == 'QUIZ'
                                  ? MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.024
                                  : widget.situation ==
                                  'QUIZRESULT'
                                  ? MediaQuery
                                  .of(
                                  context)
                                  .size
                                  .width *
                                  0.065
                                  : 10,
                              child: Container(
                                width: widget.situation == 'BOOKLIST'
                                    ? MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.13
                                    : widget.situation == 'BOOK'
                                    ? MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.16
                                    : widget.situation == 'WORDLIST'
                                    ? MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.16
                                    : widget.situation == 'WORD'
                                    ? MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.17
                                    : widget.situation ==
                                    'QUIZ'
                                    ? MediaQuery
                                    .of(
                                    context)
                                    .size
                                    .width *
                                    0.19
                                    : widget.situation ==
                                    'QUIZRESULT'
                                    ? MediaQuery
                                    .of(
                                    context)
                                    .size
                                    .width *
                                    0.11
                                    : 10,
                                color: Colors.transparent,
                                child: Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    donggleTalk,
                                    style: CustomFontStyle.textMedium,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                            : Container(),
                      );
                    },
                  ),
                )
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
                  sayDonggle(Constant.s3BaseUrl + donggleTalkModel.dongglesTalk["dgSoundPath"]);
                });
                setTouchedDonggle(true);
              },
              child: widget.situation == 'QUIZRESULT'
                  ? Image.asset(
                AppIcons.donggle_quiz,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.22,
              )
                  : Image.asset(
                AppIcons.donggle,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
