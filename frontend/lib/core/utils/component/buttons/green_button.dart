import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class GreenButton extends StatelessWidget {
  final String textContent;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const GreenButton(
      this.textContent, {
        super.key,
        required this.onPressed,
        this.textStyle,
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: textStyle ?? CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
        backgroundColor: AppColors.success,
        shadowColor: AppColors.black,
        elevation: 10,
      ),
      child: Text(
        textContent,
        style: textStyle ?? CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
      ),
    );
  }
}
