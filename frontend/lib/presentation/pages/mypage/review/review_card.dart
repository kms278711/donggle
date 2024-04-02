import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/pages/mypage/Book/new_review_modal.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatefulWidget {
  final VoidCallback? onReviewChanged;
  final Review review;

  const ReviewCard(this.review, {this.onReviewChanged, super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late Directory documentDirectory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      documentDirectory = await getApplicationDocumentsDirectory();
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String path = widget.review.coverPath ?? "";
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.width * 0.02,
        left: MediaQuery.of(context).size.width * 0.01,
        right: MediaQuery.of(context).size.width * 0.01,
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: ShapeDecoration(
        color: const Color.fromRGBO(240, 240, 240, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 15,
            offset: Offset(15, 15),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Stack(
          children: [
            Center(
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _isLoading ? const CircularProgressIndicator() : Image.file(
                        File('${documentDirectory.path}/$path'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      RatingBar.builder(
                        initialRating: widget.review.score,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: MediaQuery.of(context).size.width * 0.02,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            widget.review.content,
                            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: 0,
                child: Row(
                  children: [
                    GreenButton(
                      "수정",
                      onPressed: () async {
                        await Provider.of<BookModel>(context, listen: false)
                            .setCurrentBookId(widget.review.bookId ?? 0);
                        if (!context.mounted) return;
                        DialogUtils.showCustomDialog(context,
                            contentWidget: NewReviewModal(onModalClose: () => widget.onReviewChanged?.call()));
                      },
                      textStyle: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    RedButton(
                      "삭제",
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "정말로 삭제하시겠습니까?",
                                  style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
                                ),
                                actions: [
                                  GreenButton(
                                    "확인",
                                    onPressed: () async {
                                      String msg = await Provider.of<ReviewModel>(context, listen: false)
                                          .deleteMyReview(
                                              Provider.of<UserProvider>(context, listen: false).getAccessToken(),
                                              widget.review.bookId ?? 0);
                                      if (msg == "Success") {
                                        widget.onReviewChanged?.call();
                                        showToast("리뷰 삭제에 성공하였습니다.");
                                      } else {
                                        showToast(msg, backgroundColor: AppColors.error);
                                      }
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                    },
                                    textStyle:
                                        CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                                  ),
                                  RedButton(
                                    "취소",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    textStyle:
                                        CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                                  ),
                                ],
                              );
                            });
                      },
                      textStyle: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
