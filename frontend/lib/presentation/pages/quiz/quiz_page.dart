import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/component/icons/circle_back_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_quiz.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/pages/modal/finish_quiz_modal.dart';
import 'package:frontend/presentation/pages/modal/stop_quiz_modal.dart';
import 'package:frontend/presentation/pages/quiz/finish_quiz_page.dart';
import 'package:frontend/presentation/provider/quiz_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizModel quizModel;
  late UserProvider userProvider;
  String accessToken = "";
  CarouselController carouselController = CarouselController();
  late QuizProvider quizProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    quizModel = Provider.of<QuizModel>(context, listen: false);
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
  }

  // 선택된 답변 업데이트를 위한 콜백 함수
  void updateSelectedAnswer(int index, dynamic answer) {
    quizProvider.updateAnswer(index, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle(" Quiz"),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.1,
            child: GreenButton(
              "다 풀었어요~!",
              onPressed: () {
                if (quizProvider.selectedAnswers!.contains(null)) {
                  showToast('풀지않은 문제가 있습니다.', backgroundColor: AppColors.error);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return finishQuiz(
                        title: "퀴즈",
                        onConfirm: () {
                          DialogUtils.showCustomDialog(context,
                              contentWidget: FinishQuizPage(
                                  quizProvider.selectedAnswers!));
                          context.pushReplacement('/main/1/0');
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.12,
            left: MediaQuery.of(context).size.height * 0.16,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder<String>(
                future: quizModel.getWordQuizzes(accessToken),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 데이터 로드 중이면 로딩 인디케이터를 보여줍니다.
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // 에러가 발생했으면 에러 메시지를 보여줍니다.
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // 데이터가 성공적으로 로드되면, 로드된 데이터를 기반으로 UI를 구성합니다.
                    // 예제에서는 "Success" 문자열만 반환하지만, 실제로는 JSON 파싱 등을 수행할 수 있습니다.
                    if (snapshot.data == "Success") {
                      quizProvider.selectedAnswers = List<dynamic>.generate(
                          quizModel.quizzes.length, (index) => null);
                      // 데이터 로딩 성공 UI
                      return QuizCarousel(
                        quizzes: quizModel.quizzes,
                        onAnswerSelected: updateSelectedAnswer,
                      );
                    } else {
                      // 서버로부터 "Success" 이외의 응답을 받았을 경우의 처리
                      return Center(child: Text(snapshot.data!));
                    }
                  } else {
                    // 그 외의 경우
                    return const Center(child: Text('Unknown error'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizCarousel extends StatefulWidget {
  final List<dynamic> quizzes;
  final Function(int, dynamic) onAnswerSelected;

  const QuizCarousel(
      {super.key, required this.quizzes, required this.onAnswerSelected});

  @override
  State<QuizCarousel> createState() => _QuizCarouselState();
}

class _QuizCarouselState extends State<QuizCarousel> {
  late QuizProvider quizProvider;

  @override
  void initState() {
    super.initState();
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
  }

  // late List<dynamic> selectAnswer;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // quizzes 리스트에 기반하여 selectedAnswer 초기화
  //   selectAnswer = List<dynamic>.filled(widget.quizzes.length, null);
  // }

  CarouselController buttonCarouselController = CarouselController();

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            // 마지막에서 처음으로 안 가도록
            autoPlay: false,
            // 자동 재생 여부
            viewportFraction: 1,
            // 뷰포트 대비 항목 크기 비율
            aspectRatio: 16 / 8.5,
            // 항목의 종횡비
            initialPage: 0,
            // 초기 페이지 인덱스
            onPageChanged: (index, reason) {
              // 페이지가 변경될 때마다 현재 페이지 인덱스를 업데이트합니다.
              setState(() {
                _currentPageIndex = index;
              });
            },
          ),
          items: widget.quizzes.asMap().entries.map((entry) {
            int quizIndex = entry.key; // 현재 퀴즈 인덱스
            var quiz = entry.value; // 핸재 퀴즈 객체

            // 퀴즈 목록을 캐러셀 항목으로 변환
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: const BoxDecoration(
                      // color: Colors.white,
                      ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        // decoration: BoxDecoration(color: Colors.red),
                        child: Text(
                          quiz['content'],
                          textAlign: TextAlign.start,
                          style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMediumLarge),
                        ),
                      ),
                      quiz['content'].toString().length >= 27
                          ? SizedBox()
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                      Container(
                        padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                        // width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.37,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal, // 리스트 가로로
                          itemCount: quiz['choices'].length, // 선택지의 수 만큼 아이템 생성
                          itemBuilder: (context, index) {
                            var choice =
                                quiz['choices'][index]; // 현재 인덱스에 해당하는 선택지
                            bool isSelected =
                                quizProvider.selectedAnswers![quizIndex] ==
                                    choice;
                            return GestureDetector(
                              onTap: () {
                                if (quizIndex == widget.quizzes.length - 1) {
                                  showToast('좌측 상단 다 풀었어요 버튼을 눌러주세요');
                                } else {
                                  buttonCarouselController.nextPage(
                                      duration: Duration(milliseconds: 800),
                                      curve: Curves.linear);
                                }
                                widget.onAnswerSelected(quizIndex, choice);
                                setState(() {
                                  quizProvider.selectedAnswers![quizIndex] =
                                      choice;
                                });
                              },
                              child: Container(
                                // margin: const EdgeInsets.symmetric(horizontal: 10),
                                // 가로 여백 설정
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: Constant.s3BaseUrl +
                                            choice['choiceImagePath'],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    isSelected
                                        ? Positioned(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            child: Image.asset(
                                              AppIcons.check_mark,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.17,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        _currentPageIndex == 0
            ? Container()
            : Positioned(
                left: MediaQuery.of(context).size.height * 0,
                bottom: MediaQuery.of(context).size.height * 0.32,
                child: GestureDetector(
                  onTap: () {
                    buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.linear);
                  },
                  child: CircleBackIcon(
                      size: MediaQuery.of(context).size.width * 0.03),
                ),
              ),
        _currentPageIndex == widget.quizzes.length - 1
            ? Container()
            : Positioned(
                right: MediaQuery.of(context).size.height * -0.05,
                bottom: MediaQuery.of(context).size.height * 0.32,
                child: Transform(
                  transform: Matrix4.rotationY(pi),
                  child: GestureDetector(
                    onTap: () {
                      buttonCarouselController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.linear);
                    },
                    child: CircleBackIcon(
                        size: MediaQuery.of(context).size.width * 0.03),
                  ),
                ),
              ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.36,
          child: Text(
            '${_currentPageIndex + 1} / ${widget.quizzes.length}',
            textAlign: TextAlign.center,
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium)
          ),
        ),
      ],
    );
  }
}
