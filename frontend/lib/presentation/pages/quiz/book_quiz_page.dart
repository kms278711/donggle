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
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_quiz.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/pages/quiz/finish_quiz_page.dart';
import 'package:frontend/presentation/provider/quiz_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookQuizPage extends StatefulWidget {
  final String? bookId;

  const BookQuizPage({super.key, required this.bookId});

  @override
  State<BookQuizPage> createState() => _BookQuizPageState();
}

class _BookQuizPageState extends State<BookQuizPage> {
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
                  print(quizProvider.selectedAnswers);
                } else {
                  DialogUtils.showCustomDialog(context,
                      contentWidget:
                          FinishQuizPage(quizProvider.selectedAnswers!));
                  context.pushReplacement('/main/0/0');
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
                future: quizModel.getBookQuizzes(accessToken, widget.bookId),
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
                          quizModel.bookQuizzes.length, (index) => null);
                      // 데이터 로딩 성공 UI
                      return QuizCarousel(
                        bookQuizzes: quizModel.bookQuizzes,
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
  final List<dynamic> bookQuizzes;
  final Function(int, dynamic) onAnswerSelected;

  const QuizCarousel(
      {super.key, required this.bookQuizzes, required this.onAnswerSelected});

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

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        // 마지막에서 처음으로 안 가도록
        autoPlay: false,
        // 자동 재생 여부
        viewportFraction: 1,
        // 뷰포트 대비 항목 크기 비율
        aspectRatio: 16 / 9,
        // 항목의 종횡비
        initialPage: 0, // 초기 페이지 인덱스
      ),
      items: widget.bookQuizzes.asMap().entries.map((entry) {
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
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Text(
                      quiz['content'],
                      textAlign: TextAlign.start,
                      style: CustomFontStyle.textMediumLarge,
                    ),
                  ),
                  quiz['content'].toString().length >= 27
                      ? SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                  Container(
                    // color: Colors.red,
                    padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                    // width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // 리스트 가로로
                      itemCount: quiz['choices'].length, // 선택지의 수 만큼 아이템 생성
                      itemBuilder: (context, index) {
                        var choice = quiz['choices'][index]; // 현재 인덱스에 해당하는 선택지
                        bool isSelected =
                            quizProvider.selectedAnswers![quizIndex] == choice;
                        return GestureDetector(
                          onTap: () {
                            widget.onAnswerSelected(quizIndex, choice);
                            setState(() {
                              quizProvider.selectedAnswers![quizIndex] = choice;
                            });
                          },
                          child: Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 1),
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
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                Positioned(
                                  bottom: MediaQuery.of(context).size.height * 0.04,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.166,
                                    color: Colors.transparent,
                                    child: Text(
                                      choice["choice"],
                                      textAlign: TextAlign.center,
                                      style: CustomFontStyle.textMedium,
                                    ),
                                  ),
                                ),
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
    );
  }
}
