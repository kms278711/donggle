import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class NewReviewModal extends StatefulWidget {
  final VoidCallback? onModalClose;

  const NewReviewModal({this.onModalClose, super.key});

  @override
  State<NewReviewModal> createState() => _NewReviewModalState();
}

class _NewReviewModalState extends State<NewReviewModal> {
  late BookModel bookModel;
  late ReviewModel reviewModel;
  late UserProvider userProvider;
  String accessToken = "";
  int bookId = 0;
  Review myReview = Review(score: 0, content: "");
  double score = 0.0;
  String content = "";
  bool isReviewed = false;
  final TextEditingController _editTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // It's now safe to perform the async operations
      bookModel = Provider.of<BookModel>(context, listen: false);
      reviewModel = Provider.of<ReviewModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);

      // Check if the widget is still mounted before updating its state
      if (mounted) {
        setState(() {
          Book book = bookModel.nowBook;
          bookId = book.bookId;
          myReview = Review.fromJson(book.myReview ?? {'score': 0.0, 'content': ""});
          isReviewed = myReview.score != 0.0 || myReview.content != "";
          score = myReview.score;
          content = myReview.content;
          accessToken = userProvider.getAccessToken();
          _editTextController.text = content;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree.
    _editTextController.dispose();
    super.dispose();
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
                  children: [
                    Text(isReviewed ? "내 리뷰 수정하기" : "내 리뷰 남기기",
                        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMediumSmall)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    RatingBar.builder(
                      initialRating: myReview.score,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: MediaQuery.of(context).size.width * 0.02,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {
                        score = value;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: TextField(
                                textAlignVertical: const TextAlignVertical(y: -1.0),
                                controller: _editTextController,
                                onChanged: (String value) {
                                  content = value;
                                },
                                maxLength: 85,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GreenButton("확인", onPressed: () async {
                          if (score == 0.0) {
                            showToast("평점을 설정해주세요.", backgroundColor: AppColors.error);
                          } else if (content == "") {
                            showToast("리뷰를 남겨주세요.", backgroundColor: AppColors.error);
                          } else {
                            if (isReviewed) {
                              String result = await reviewModel.editMyReview(accessToken, bookId, score, content);
                              if (result == "Success") {
                                showToast("리뷰를 성공적으로 수정했습니다!");
                                widget.onModalClose?.call();
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              } else {
                                showToast(result, backgroundColor: AppColors.error);
                              }
                            } else {
                              String result = await reviewModel.setMyReview(accessToken, bookId, score, content);
                              if (result == "Success") {
                                showToast("리뷰를 성공적으로 남겼습니다!");
                                await bookModel.getCurrentBookPurchase(accessToken, bookId);
                                widget.onModalClose?.call();
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                              } else {
                                showToast(result, backgroundColor: AppColors.error);
                              }
                            }
                          }
                        }),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        RedButton("취소", onPressed: () {
                          score = myReview.score;
                          content = myReview.content;
                          _editTextController.clear();
                          Navigator.of(context).pop();
                        }),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
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
