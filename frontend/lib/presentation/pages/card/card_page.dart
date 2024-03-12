import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle("Notes"),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.12,
            left: MediaQuery.of(context).size.height * 0.16,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                // TODO: 도감 리스트 받아와서 여기서 출력
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "등록된 단어가 없습니다.",
                    textAlign: TextAlign.center,
                    style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}