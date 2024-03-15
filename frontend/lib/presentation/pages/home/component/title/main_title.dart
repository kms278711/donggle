import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';



class MainTitle extends StatelessWidget {
  final String titleString;

  const MainTitle(this.titleString, {super.key});

  bool containsKorean(String text) {
    RegExp koreanRegex = RegExp(r'[\u3131-\uD79D]');
    return koreanRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.38,
            child: containsKorean(titleString)
                ? Text(
                    titleString,
                    style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMain),
                  )
                : Text(
                    titleString,
                    style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMainEng),
                  ),
          ),
        ],
      ),
    );
  }
}
