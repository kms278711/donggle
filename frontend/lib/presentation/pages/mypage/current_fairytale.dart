import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class CurrentFairytale extends StatelessWidget {
  const CurrentFairytale({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.748 - 20,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "진행중인 동화가 없습니다.",
            textAlign: TextAlign.center,
            style: CustomFontStyle.bodyLarge,
          ),
        ],
      ),
    );
  }
}
