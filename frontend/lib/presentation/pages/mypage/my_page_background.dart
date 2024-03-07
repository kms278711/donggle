import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/icons/cards_icon.dart';
import 'package:frontend/core/utils/component/icons/home_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';

class MyPageBackground extends StatefulWidget {
  const MyPageBackground({super.key});

  @override
  State<MyPageBackground> createState() => _MyPageBackgroundState();
}

class _MyPageBackgroundState extends State<MyPageBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppIcons.background),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "동 글 이",
                    style: TextStyle(fontSize: 80),
                  ),
                  Row(
                    children: [
                      const HomeIcon(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const CardsIcon(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const SoundIcon(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.82,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                        border: Border(
                          top: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                          bottom: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                      ),
                      child: Text("진행 중인 동화", textAlign: TextAlign.center,style: CustomFontStyle.selectedLarge,),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide.none,
                          left: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: AppColors.primaryContainer,
                          ),
                          right: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: AppColors.primaryContainer,
                          ),
                          bottom: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                      ),
                      child: Text("동화 구매", textAlign: TextAlign.center,style: CustomFontStyle.unSelectedLarge,),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50)),
                        border: Border(
                          top: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                          bottom: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                      ),
                      child: Text("회원 정보", textAlign: TextAlign.center,style: CustomFontStyle.unSelectedLarge,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}
