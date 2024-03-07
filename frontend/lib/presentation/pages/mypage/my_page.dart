import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/presentation/pages/mypage/my_page_background.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyPageBackground(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.252,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("진행중인 동화가 없습니다.", textAlign: TextAlign.center,style: CustomFontStyle.bodyLarge,),
                  ],
                ),
          ))
        ],
      ),
    );
  }
}
