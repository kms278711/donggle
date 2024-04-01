import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
        child: const Text(
          "Loading...",
        ));
  }
}
