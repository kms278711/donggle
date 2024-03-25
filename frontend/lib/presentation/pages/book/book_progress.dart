import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/icons/back_icon.dart';
import 'package:frontend/core/utils/component/icons/end_icon.dart';
import 'package:frontend/core/utils/component/icons/skip_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/book/modal/book_finish_modal.dart';
import 'package:frontend/presentation/pages/book/modal/picture_quiz.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/routes.dart';
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
  bool _isLastSentence = false;

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
    bookPageSentences: [BookPageSentences(bookPageSentenceId: 0, sequence: 0, sentence: "", sentenceSoundPath: "")],
  );
  String url = "";

  void finishSentence() {
    // if(_isLastSentence && _isLastPage){
    //   globalRouter.pushReplacement(RoutePath.main0);
    // }
    if (_isLastSentence && _isLastPage){
      DialogUtils.showCustomDialog(context,
          contentWidget: BookFinishModal(bookId, onModalClose: () {
            setState(() {

            });
          }));
    }
    else if (_isLastSentence) {
      globalRouter.pushReplacement('/bookProgress/$bookId/${pageId + 1}/0');
    } else {
      setState(() {
        sentenceId++;
        if (sentenceId == nowPage.bookPageSentences.length - 1) {
          _isLastSentence = true;
        }
      });
    }
  }

  void goNext() {
    if (educationId == nowPage.bookPageSentences[sentenceId].bookPageSentenceId) {
      if (nowPage.education?.gubun == "NOWORD") {
        /// OX문제
        print("------------ noword");
        finishSentence();
      } else if (nowPage.education?.category == "PICTURE") {
        /// 그림문제
        print("------------ picture");
        DialogUtils.showCustomDialog(context, contentWidget: PictureQuiz(
          onModalClose: () {
            finishSentence();
          },
        ));
      } else if (nowPage.education?.category == "EXPRESSION") {
        /// 표정문제
        print("------------ expression");
        finishSentence();
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
    if (sentenceId == 0 && nowPage.bookPageId == 1) {
      showToast("첫 페이지 입니다.", backgroundColor: AppColors.error);
    } else if (sentenceId == 0) {
      globalRouter.pushReplacement('/bookProgress/$bookId/${pageId - 1}/1');
    } else {
      setState(() {
        sentenceId--;
        if(_isLastSentence) _isLastSentence = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.pause();
    bookId = int.parse(widget.bookId);
    pageId = int.parse(widget.bookPageId);
    isForward = int.parse(widget.isForward);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      totalPage = bookModel.BookDetail['totalPage'];
      if(pageId == totalPage) _isLastPage = true;

      String result = await bookModel.getBookPage(accessToken, bookId, pageId);
      if (result == "Success") {
        await bookModel.setBookPage(accessToken, bookId, pageId);
      } else {
        showToast(result, backgroundColor: AppColors.error);
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
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
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
                          maxWidth: MediaQuery.of(context).size.width * 0.95, // Set your desired max width here
                        ),
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(217, 217, 217, 0.85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          nowPage.bookPageSentences[sentenceId].sentence,
                          textAlign: TextAlign.center,
                          style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMediumLarge2),
                        )),
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
                  onTap: goNext,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const EndIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
