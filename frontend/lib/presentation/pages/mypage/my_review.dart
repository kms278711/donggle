import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class MyReview extends StatelessWidget {
  const MyReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: Text(
        "내가 남긴 리뷰",
        style: CustomFontStyle.textMedium,
      ),
    );
  }
}
