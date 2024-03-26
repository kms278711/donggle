import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/icons/cards_icon_main.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/component/icons/home_icon_main.dart';
import 'package:frontend/core/utils/component/icons/my_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/core/utils/component/icons/test_icon.dart';
import 'package:frontend/domain/model/model_quiz.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/card/card_page.dart';
import 'package:frontend/presentation/pages/home/component/background/back_ground_below.dart';
import 'package:frontend/presentation/pages/home/component/background/background_screen.dart';
import 'package:frontend/presentation/pages/home/component/background/background_upper.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';
import 'package:frontend/presentation/pages/modal/stop_quiz_modal.dart';
import 'package:frontend/presentation/pages/quiz/book_quiz_page.dart';
import 'package:frontend/presentation/pages/quiz/quiz_page.dart';
import 'package:frontend/presentation/provider/quiz_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final String? id;
  final String? bookId;

  const MainScreen({
    this.id,
    this.bookId,
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  bool _isLoading = true; // Initial state is loading
  late QuizProvider quizProvider; // 퀴즈 저장했던거 초기화 하기 위해서 부름
  late QuizModel quizModel;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    assetsAudioPlayer.play();
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizModel = Provider.of<QuizModel>(context, listen: false);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _isLoading = true; // Reset loading state on widget update
      _updateSelectedIndex();
    }
  }

  void _updateSelectedIndex() {
    // Simulate an asynchronous operation with a post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String pageIndex = widget.id ?? '0';
      try {
        setState(() {
          _selectedIndex = int.parse(pageIndex);
          _isLoading = false; // Loading complete
        });
      } on FormatException {
        setState(() {
          _selectedIndex = 0; // Default value in case of parsing error
          _isLoading = false; // Loading complete
        });
      }
    });
  }

  // final List<Widget> _pages = [
  //   const HomePage(),
  //   const CardPage(),
  //   const QuizPage(),
  //   const BookQuizPage(bookId: bookId),
  // ];

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const CardPage();
      case 2:
        return const QuizPage();
      case 3:
        // 여기서 widget.bookId를 전달합니다. 동적 생성이므로 문제없습니다.
        return BookQuizPage(bookId: widget.bookId);
      default:
        return const HomePage(); // 기본값으로 홈페이지를 반환
    }
  }

  final List _icons = [
    const CardsIconMain(),
    const HomeIconMain(),
    const HomeIconMain(),
    const HomeIconMain(),
  ];

  void _onButtonPressed(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: BackgroundScreen(),
      );
    }

    return Scaffold(
      body: Indexer(
        children: [
          const Indexed(index: -5, child: BackGroundBelow()),
          Indexed(
            index: 0,
            child: _buildPage(),
          ),
          Indexed(
            index: 1000,
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Row(
                children: [
                  const TestIcon(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  IconButton(
                    icon: _icons[_selectedIndex], // replace with actual icons
                    onPressed: () {
                      _selectedIndex == 0
                          ? _onButtonPressed(1)
                          : _selectedIndex == 1
                              ? _onButtonPressed(0)
                              : _selectedIndex == 2
                                  ? () {
                                      _onButtonPressed(0);
                                      quizProvider
                                          .clearAnswers(quizModel.quizzes);
                                    }()
                                  : () {
                                      _onButtonPressed(0);
                                      quizProvider
                                          .clearAnswers(quizModel.bookQuizzes);
                                    }();
                      // _selectedIndex == 0
                      //     ? _onButtonPressed(1)
                      //     : _onButtonPressed(0);
                      // quizProvider.clearAnswers(quizModel.quizzes);
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const MyIcon(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  SoundIcon(assetsAudioPlayer),
                ],
              ),
            ),
          ),
          (_selectedIndex == 1)
              ? Indexed(
                  index: 1000,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: GreenButton(
                      "문제 풀기",
                      onPressed: () {
                        _onButtonPressed(2);
                        // context.pushReplacement('/main/2');
                      },
                    ),
                  ),
                )
              : Container(),
          (_selectedIndex == 2)
              ? Indexed(
                  index: 1000,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.065,
                    child: Builder(
                      builder: (newContext) {
                        return IconButton(
                          icon: const CloseCircle(),
                          onPressed: () {
                            showDialog(
                              context: newContext,
                              builder: (BuildContext dialogContext) {
                                return stopQuiz(
                                  title: "퀴즈 종료",
                                  content: "퀴즈를 종료하시겠습니까?",
                                  onConfirm: () {
                                    _onButtonPressed(1);
                                    quizProvider
                                        .clearAnswers(quizModel.quizzes);
                                    showToast('종료되었습니다.');
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Container(),
          (_selectedIndex == 3)
              ? Indexed(
                  index: 1000,
                  child: Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.065,
                    child: Builder(
                      builder: (newContext) {
                        return IconButton(
                          icon: const CloseCircle(),
                          onPressed: () {
                            showDialog(
                              context: newContext,
                              builder: (BuildContext dialogContext) {
                                return stopQuiz(
                                  title: "퀴즈 종료",
                                  content: "퀴즈를 종료하시겠습니까?",
                                  onConfirm: () {
                                    _onButtonPressed(0);
                                    quizProvider
                                        .clearAnswers(quizModel.quizzes);
                                    showToast('종료되었습니다.');
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Container(),
          BackgroundUpper()
        ],
      ),
    );
  }
}
