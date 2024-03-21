import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/pages/mypage/review/review_card.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyReview extends StatefulWidget {
  const MyReview({super.key});

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  late ReviewModel reviewModel;
  late UserProvider userProvider;
  List<dynamic> myReviews = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchReviews());
  }

  Future<void> fetchReviews() async {
    reviewModel = Provider.of<ReviewModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    String accessToken = userProvider.getAccessToken();

    await reviewModel.getMyReviews(accessToken);

    if (mounted) {
      setState(() {
        myReviews = reviewModel.myReviews;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
          child: Text(
            "내가 남긴 리뷰",
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: myReviews.length,
            itemBuilder: (BuildContext context, int index) {
              Review review = Review.fromJson(myReviews[index]);
              return ReviewCard(review, onReviewChanged: fetchReviews);
            },
            shrinkWrap: true,
          ),
        )
      ],
    );
  }
}
