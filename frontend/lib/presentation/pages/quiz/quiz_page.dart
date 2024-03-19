import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_word_quiz.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizWordModel quizModel;
  late UserProvider userProvider;
  String accessToken = "";
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    quizModel = Provider.of<QuizWordModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle(" Quiz"),
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // 에러가 발생했으면 에러 메시지를 보여줍니다.
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // 데이터가 성공적으로 로드되면, 로드된 데이터를 기반으로 UI를 구성합니다.
                    // 예제에서는 "Success" 문자열만 반환하지만, 실제로는 JSON 파싱 등을 수행할 수 있습니다.
                    if (snapshot.data == "Success") {
                      // 데이터 로딩 성공 UI
                      return QuizCarousel(quizzes: quizModel.quizzes);
                    } else {
                      // 서버로부터 "Success" 이외의 응답을 받았을 경우의 처리
                      return Center(child: Text(snapshot.data!));
                    }
                  } else {
                    // 그 외의 경우
                    return Center(child: Text('Unknown error'));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuizCarousel extends StatelessWidget {
  final List<dynamic> quizzes; // 퀴즈 목록을 저장하는 변수

  QuizCarousel({Key? key, required this.quizzes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        // 자동 재생 여부
        enlargeCenterPage: true,
        // 중앙 항목을 크게 표시
        viewportFraction: 1,
        // 뷰포트 대비 항목 크기 비율
        aspectRatio: 16 / 9,
        // 항목의 종횡비
        initialPage: 0, // 초기 페이지 인덱스
      ),
      items: quizzes.map((quiz) {
        // 퀴즈 목록을 캐러셀 항목으로 변환
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                // color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Text(
                      quiz['content'],
                      textAlign: TextAlign.start,
                      style: CustomFontStyle.textMediumLarge,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // 리스트를 가로로 스크롤 가능하게 설정
                      itemCount: quiz['choices'].length, // 선택지의 수 만큼 아이템 생성
                      itemBuilder: (context, index) {
                        var choice = quiz['choices'][index]; // 현재 인덱스에 해당하는 선택지
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10), // 가로 여백 설정
                          child: Text(
                            choice['choice'],
                            style: CustomFontStyle.textSmall,
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
