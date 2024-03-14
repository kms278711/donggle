import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';

class signOut extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;

  const signOut({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textLarge),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.1,
        child: Text(
          content,
          style: CustomFontStyle.getTextStyle(
              (context), CustomFontStyle.textMediumLarge),
        ),
      ),
      actions: <Widget>[
        GreenButton(
          "취소",
          onPressed: () => Navigator.of(context).pop(), // 모달 닫기
        ),
        TextButton(
          child: Text(
            "예, 탈퇴하겠습니다.",
            style: CustomFontStyle.getTextStyle(
                (context), CustomFontStyle.textMoreSmall),
          ),
          onPressed: () {// 모달 닫기
            onConfirm();
          },
        ),
      ],
    );
  }
}
