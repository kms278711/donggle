import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/effect_sound.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/pages/mypage/Book/new_review_modal.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class BookFinishModal extends StatefulWidget {
  final int bookId;
  final VoidCallback? onModalClose;

  const BookFinishModal(this.bookId, {this.onModalClose, super.key});

  @override
  State<BookFinishModal> createState() => _BookFinishModalState();
}

class _BookFinishModalState extends State<BookFinishModal> {
  late BookModel bookModel;
  late UserProvider userProvider;
  late MainProvider mainProvider;
  String accessToken = "";
  bool _notRead = true;
  bool _notReviewed = true;
  int index = 0;

  @override
  void initState() {
    super.initState();

    effectPlaySound("assets/music/book_finish.mp3", 0.5);

    // Schedule a callback for the end of this frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // It's now safe to perform the async operations
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      mainProvider = Provider.of<MainProvider>(context, listen: false);

      await bookModel.getCurrentBookPurchase(accessToken, widget.bookId);

      if (mounted) {
        setState(() {
          _notRead = !bookModel.books[widget.bookId - 1]['isRead'];
          Book book = bookModel.nowBook;
          Review myReview = Review.fromJson(book.myReview ?? {'score': 0.0, 'content': ""});
          _notReviewed = myReview.score == 0.0 && myReview.content == "";
          index = bookModel.progresses.indexWhere((progress) => progress.bookId == widget.bookId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.95,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "동화가 끝났어요!",
                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GreenButton("처음부터 다시보기", onPressed: () {
                          Navigator.of(context).pop();
                          globalRouter.pushReplacement('/bookProgress/${widget.bookId}/1/0');
                          bookModel.progresses[index].isDone = false;
                        }),
                        GreenButton("홈으로 돌아가기", onPressed: () {
                          mainProvider.isSoundOn = true;
                          Navigator.of(context).pop();
                          globalRouter.pushReplacement(RoutePath.main0);
                          if(_notRead && _notReviewed) {
                            DialogUtils.showCustomDialog(context, contentWidget: const NewReviewModal());
                          }
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
