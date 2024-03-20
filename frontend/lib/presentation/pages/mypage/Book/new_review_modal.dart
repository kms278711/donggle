import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';

class NewReviewModal extends StatelessWidget {
  const NewReviewModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMedium),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.95,
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
                  Text("내 리뷰 남기기"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GreenButton("확인", onPressed: () => Navigator.of(context).pop()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      RedButton("취소", onPressed: () => Navigator.of(context).pop()),
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
    );
  }
}
