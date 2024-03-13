import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';

class nickNameUpdate extends StatelessWidget {
  final String title;
  final Widget input;
  final Function onConfirm;

  const nickNameUpdate({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: CustomFontStyle.getTextStyle(
            context, CustomFontStyle.textMediumLarge2),
      ),
      content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.05,
          child: input),
      actions: <Widget>[
        GreenButton(
          "확인",
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // 모달 닫기
          }, // 모달 닫기
        ),
        TextButton(
          child: Text(
            "취소",
            style: CustomFontStyle.getTextStyle(
                (context), CustomFontStyle.textMedium),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // 모달 닫기
          },
        ),
      ],
    );
  }
}
