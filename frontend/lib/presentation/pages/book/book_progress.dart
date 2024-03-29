import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/icons/back_icon.dart';
import 'package:frontend/core/utils/component/icons/end_icon.dart';
import 'package:frontend/core/utils/component/icons/skip_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/book/modal/book_finish_modal.dart';
import 'package:frontend/presentation/pages/book/modal/expression_quiz.dart';
import 'package:frontend/presentation/pages/book/modal/noword_quiz.dart';
import 'package:frontend/presentation/pages/book/modal/picture_quiz.dart';
import 'package:frontend/presentation/pages/modal/stop_quiz_modal.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class BookProgress extends StatefulWidget {
  final String bookId;
  final String bookPageId;
  final String isForward;

  const BookProgress(this.bookId, this.bookPageId, this.isForward, {super.key});

  @override
  State<BookProgress> createState() => _BookProgressState();
}

class _BookProgressState extends State<BookProgress> {
  bool _isLoading = true;
  bool _isLastPage = false;
  bool _isLastSentence = false; // 마지막 문장인지 판별, 전 페이지로 넘어가기 위해
  bool _isFirstSentence = false; // 첫 문장인지 판별, 전 페이지로 넘어가기 위해
  bool _isUnexsist = false;
  bool _isSkiped = false;

  late BookModel bookModel;
  late UserProvider userProvider;
  String accessToken = "";
  int bookId = 0;
  int pageId = 0;
  int isForward = 0;
  int sentenceId = 0;
  int educationId = 10000;
  int totalPage = 0;
  BookPage nowPage = BookPage(
    bookPageId: 0,
    bookImagePath: "",
    page: 0,
    content: "",
    bookPageSentences: [
      BookPageSentences(
          bookPageSentenceId: 0,
          sequence: 0,
          sentence: "",
          sentenceSoundPath: "")
    ],
  );
  String url = "";

  Future<void> finishSentence() async {
    // if(_isLastSentence && _isLastPage){
    //   globalRouter.pushReplacement(RoutePath.main0);
    // }
    if (_isLastSentence && _isLastPage) {
      bool isRead = bookModel.books[bookId - 1]["isRead"] ?? false;
      if (!isRead) {
        await bookModel.setIsRead(accessToken, bookId);
      }
      DialogUtils.showCustomDialog(context,
          contentWidget: BookFinishModal(bookId, onModalClose: () {
            setState(() {});
          }));
    } else if (_isLastSentence) {
      globalRouter.pushReplacement('/bookProgress/$bookId/${pageId + 1}/0');
    } else {
      setState(() {
        sentenceId++;
        if (sentenceId == nowPage.bookPageSentences.length - 1) {
          _isLastSentence = true;
        }
        backgroundLinePlay(Constant.s3BaseUrl +
            nowPage.bookPageSentences[sentenceId].sentenceSoundPath);
      });
    }
  }

  void goNext() {
    if (educationId ==
        nowPage.bookPageSentences[sentenceId].bookPageSentenceId) {
      backgroundLine.stop();
      if (nowPage.education?.gubun == "NOWORD") {
        /// OX문제
        // print("------------ noword");
        DialogUtils.showCustomDialog(context, contentWidget: NowordQuiz(
          onModalClose: () {
            finishSentence();
          },
        ));
      } else if (nowPage.education?.category == "PICTURE") {
        /// 그림문제
        // print("------------ picture");
        DialogUtils.showCustomDialog(context, contentWidget: PictureQuiz(
          onModalClose: () {
            finishSentence();
          },
        ));
      } else if (nowPage.education?.category == "EXPRESSION") {
        /// 표정문제
        // print("------------ expression");
        DialogUtils.showCustomDialog(context, contentWidget: ExpressionQuiz(
          onModalClose: () {
            finishSentence();
          },
        ));
      } else if (nowPage.education?.category == "ACTION") {
        /// 동작문제
        print("------------ action");
        finishSentence();
      }
    } else {
      finishSentence();
    }
  }

  void goPrevious() {
    // if (sentenceId == 0 && nowPage.bookPageId == 1) {
    //   showToast("첫 페이지 입니다.", backgroundColor: AppColors.error);
    // } else if (sentenceId == 0) {
    //   globalRouter.pushReplacement('/bookProgress/$bookId/${pageId - 1}/1');
    // } else {
    //   setState(() {
    //     finishSentencePrevious();
    //     if (_isLastSentence) _isLastSentence = false;
    //   });
    // }
    if (sentenceId == 0 && nowPage.bookPageId == 1) {
      showToast("첫 페이지 입니다.", backgroundColor: AppColors.error);
    } else if (sentenceId == 0) {
      globalRouter.pushReplacement('/bookProgress/$bookId/${pageId - 1}/1');
    } else {
      setState(() {
        sentenceId--;
        if (sentenceId == 0) {
          _isFirstSentence = true;
        }
        backgroundLinePlay(Constant.s3BaseUrl +
            nowPage.bookPageSentences[sentenceId].sentenceSoundPath);
        if (_isLastSentence) _isLastSentence = false;
      });
    }
  }

  AudioPlayer backgroundLine = AudioPlayer();

  StreamSubscription? _audioPlayerSubscription;

  Future<void> backgroundLinePlay(String path) async {
    try {
      await backgroundLine.setUrl(path); // 오디오 파일의 URL을 설정
      await backgroundLine.play(); // 오디오 재생 시작

      await _audioPlayerSubscription?.cancel();

      _audioPlayerSubscription =
          backgroundLine.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          if (_isSkiped == false) {
            goNext();
          } else {
            _isSkiped = false;
          }
        }
      });
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    player.pause();
    bookId = int.parse(widget.bookId);
    pageId = int.parse(widget.bookPageId);
    isForward = int.parse(widget.isForward);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      totalPage = bookModel.BookDetail['totalPage'];
      if (pageId == totalPage) _isLastPage = true;

      String result = await bookModel.getBookPage(accessToken, bookId, pageId);
      if (result == "Success") {
        await bookModel.setBookPage(accessToken, bookId, pageId);
      } else {
        showToast(result, backgroundColor: AppColors.error);
        setState(() {
          _isLastSentence = true;
          _isFirstSentence = true;
          _isLastPage = true;
          _isUnexsist = true;
          finishSentence();
        });
      }

      nowPage = bookModel.nowPage;
      url = Constant.s3BaseUrl + nowPage.bookImagePath;
      if (sentenceId == nowPage.bookPageSentences.length - 1) {
        _isLastSentence = true;
      }
      educationId = nowPage.education?.bookSentenceId ?? 10000;

      if (mounted) {
        setState(() {
          if (isForward == 1) {
            sentenceId = nowPage.bookPageSentences.length - 1;
            _isLastSentence = true;
          }
          _isLoading = false; // Update loading state when done
          backgroundLinePlay(Constant.s3BaseUrl +
              nowPage.bookPageSentences[sentenceId].sentenceSoundPath);
        });
      }
    });
  }

  @override
  void dispose() {
    backgroundLine.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _isUnexsist
        ? Container()
        : Scaffold(
            body: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width *
                                    0.95, // Set your desired max width here
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.02),
                              decoration: BoxDecoration(
                                color:
                                    const Color.fromRGBO(217, 217, 217, 0.85),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                nowPage.bookPageSentences[sentenceId].sentence,
                                textAlign: TextAlign.center,
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.textMediumLarge2),
                              ))
                          // : GreenButton('시작하기', onPressed: () {
                          //     backgroundLinePlay(Constant.s3BaseUrl +
                          //         nowPage.bookPageSentences[sentenceId]
                          //             .sentenceSoundPath);
                          //     setState(() {
                          //       _isStarted = !_isStarted;
                          //     });
                          //   }),
                        ],
                      ),
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: Row(
                    children: [
                      BackIcon(
                        onTap: goPrevious,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      SkipIcon(
                        // onTap: finishSentence
                        onTap: () {
                          _isSkiped = true;
                          goNext();
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      EndIcon(onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return stopQuiz(
                              title: "동화",
                              onConfirm: () {
                                showToast('종료되었습니다.');
                                context.go(RoutePath.main0);
                              },
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
