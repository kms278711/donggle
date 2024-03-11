import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

import 'component/title/main_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle("Books"),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.11,
            left: MediaQuery.of(context).size.height * 0.16,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                // TODO: 책 리스트 받아와서 여기서 출력
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "구매한 도서가 없습니다.",
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
