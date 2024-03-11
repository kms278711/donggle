import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class RedButton extends StatelessWidget {
  final String textContent;
  final VoidCallback onPressed;

  const RedButton(
    this.textContent, {
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: CustomFontStyle.textMedium,
        backgroundColor: AppColors.error,
        shadowColor: AppColors.black,
        elevation: 10,
      ),
      child: Text(
        textContent,
        style: CustomFontStyle.textMedium,
      ),
    );
  }
}
