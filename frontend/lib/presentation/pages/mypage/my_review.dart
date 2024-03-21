import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_review.dart';
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

  String accessToken = "";

  @override
  void initState() {
    super.initState();

    // Schedule a callback for the end of this frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // It's now safe to perform the async operations
      reviewModel = Provider.of<ReviewModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();

      // Check if the widget is still mounted before updating its state
      if (mounted) {
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: Text(
        "내가 남긴 리뷰",
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
      ),
    );
  }
}
