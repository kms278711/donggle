import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class GreenButton extends StatelessWidget {
  final String textContent;
  final VoidCallback onPressed;

  const GreenButton(this.textContent, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Use the passed onPressed function here.
      style: ElevatedButton.styleFrom(
        textStyle: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
        backgroundColor: AppColors.success,
        shadowColor: AppColors.black,
        elevation: 10,
      ),
      child: Text(
        textContent,
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMedium),
      ),
    );
  }
}