import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/icons/cards_icon_mypage.dart';
import 'package:frontend/core/utils/component/icons/home_icon_mypage.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/presentation/pages/main_screen/main_screen.dart';
import 'package:frontend/presentation/pages/mypage/current_fairytale.dart';
import 'package:frontend/presentation/pages/mypage/my_page.dart';
import 'package:frontend/presentation/pages/mypage/purchase_fairytale.dart';

class MyPageBackground extends StatefulWidget {
  const MyPageBackground({super.key});

  @override
  State<MyPageBackground> createState() => _MyPageBackgroundState();
}

class _MyPageBackgroundState extends State<MyPageBackground> {
  int selectedTab = 0; // 초기에 선택된 탭의 인덱스

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    Text(
                      "동 글 이",
                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleMedium),
                    ),
                    Row(
                      children: [
                        const HomeIconMypage(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        const CardsIconMypage(),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        // Toggle between SoundIcon and SoundOffIcon based on isSoundOn
                        SoundIcon(assetsAudioPlayer),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    // Removed height to allow for flexible container height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        buildTab(
                            context,
                            0,
                            "진행 중인 동화",
                            const BorderRadius.only(
                                topLeft: Radius.circular(50))),
                        buildTab(context, 1, "동화 구매", null),
                        buildTab(
                            context,
                            2,
                            "회원 정보",
                            const BorderRadius.only(
                                topRight: Radius.circular(50))),
                        //Content based on selectedTab can be placed here
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.12,
                          left: 0,
                          child: selectedTab == 0
                              ? const CurrentFairytale()
                              : selectedTab == 1
                                  ? const PurchaseFairytale()
                                  : const MyPage(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(BuildContext context, int index, String text,
      BorderRadius? borderRadius) {
    double width = MediaQuery.of(context).size.width * 0.3;
    double height = MediaQuery.of(context).size.height * 0.12;
    bool isSelected = selectedTab == index;

    return Positioned(
      top: 0, // Adjust position based on selection
      left: width * index,
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: borderRadius,
            border: const Border(
              bottom: BorderSide(color: AppColors.primaryContainer, width: 2),
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: isSelected
                  ? CustomFontStyle.getTextStyle(context, CustomFontStyle.selectedLarge)
                  : CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
            ),
          ),
        ),
      ),
    );
  }
}
