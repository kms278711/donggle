import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/add_post_position_text.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';

class stopQuiz extends StatelessWidget {
  final String title;
  final Function onConfirm;

  const stopQuiz({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "$title 종료",
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textLarge),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.1,
        child: Text(
          "${postPositionText(title)} 종료하시겠습니까?",
          style: CustomFontStyle.getTextStyle(
              (context), CustomFontStyle.textMediumLarge),
        ),
      ),
      actions: <Widget>[
        GreenButton(
          "취소",
          onPressed: () => Navigator.of(context).pop(), // 모달 닫기
        ),
        RedButton(
          "종료",
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
