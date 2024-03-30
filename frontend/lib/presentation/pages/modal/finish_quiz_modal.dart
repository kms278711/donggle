import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';

class finishQuiz extends StatelessWidget {
  final String title;
  final Function onConfirm;

  const finishQuiz({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "다 풀었어요~!",
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textLarge),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.1,
        child: Text(
          "문제를 다 풀었나요?",
          style: CustomFontStyle.getTextStyle(
              (context), CustomFontStyle.textMediumLarge),
        ),
      ),
      actions: <Widget>[
        GreenButton(
          "네",
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          }, // 모달 닫기
        ),
        TextButton(
          child: Text(
            '아니오',
            style: CustomFontStyle.textMedium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
