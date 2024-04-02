import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/icons/cards_icon_mypage.dart';
import 'package:frontend/core/utils/component/icons/home_icon_mypage.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/mypage/Book/book_detail_pay.dart';
import 'package:frontend/presentation/pages/mypage/Book/purchase_history.dart';
import 'package:frontend/presentation/pages/mypage/current_fairytale.dart';
import 'package:frontend/presentation/pages/mypage/my_page.dart';
import 'package:frontend/presentation/pages/mypage/my_page_update.dart';
import 'package:frontend/presentation/pages/mypage/purchase_fairytale.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:provider/provider.dart';

class MyPageBackground extends StatefulWidget {
  const MyPageBackground({super.key});

  @override
  State<MyPageBackground> createState() => _MyPageBackgroundState();
}

class _MyPageBackgroundState extends State<MyPageBackground> {
  int selectedTab = 0; // 초기에 선택된 탭의 인덱스

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to interact with the context now
      context.read<MainProvider>().resetDetailPageSelection();
      context.read<MainProvider>().resetMyPageUpdate();
      context.read<MainProvider>().resetPurchaseHistory();
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (selectedTab == 0) {
      context.read<MainProvider>().resetMyPageUpdate();
    } else if (selectedTab == 1) {
      context.read<MainProvider>().resetMyPageUpdate();
    }

    if (selectedTab != 1) {
      context.read<MainProvider>().resetDetailPageSelection();
      context.read<MainProvider>().resetPurchaseHistory();
    }

    super.setState(fn);
  }

  void onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
    // Additional actions based on the selected tab can go here
  }

  @override
  Widget build(BuildContext context) {
    final isMyPageUpdateSelected = context.select<MainProvider, bool>(
        (provider) => provider.isMyPageUpdateSelected);
    final isDetailPageSelected = context
        .select<MainProvider, bool>((provider) => provider.isDetailPageSeleted);
    final isPurchaseHistorySelected = context.select<MainProvider, bool>(
        (provider) => provider.isPurchaseHistorySelected);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppIcons.background),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "동 글 이",
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.titleMedium),
                    ),
                    Row(
                      children: [
                        const HomeIconMypage(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01),
                        const CardsIconMypage(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01),
                        // Toggle between SoundIcon and SoundOffIcon based on isSoundOn
                        SoundIcon(player),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    // Removed height to allow for flexible container height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.05),
                    ),
                    child: Stack(
                      children: [
                        buildTab(
                            context,
                            0,
                            "진행 중인 동화",
                            BorderRadius.only(
                                topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.05))),
                        buildTab(context, 1, "동화 구매", null),
                        buildTab(
                            context,
                            2,
                            "회원 정보",
                            BorderRadius.only(
                                topRight: Radius.circular(MediaQuery.of(context).size.height * 0.05))),
                        //Content based on selectedTab can be placed here
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.127,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            child: selectedTab == 0
                                ? const CurrentFairytale()
                                : selectedTab == 1
                                    ? isPurchaseHistorySelected
                                        ? const PurchaseHistory()
                                        : isDetailPageSelected
                                            ? const BooksDetailPay()
                                            : const PurchaseFairytale()
                                    : isMyPageUpdateSelected
                                        ? const MyPageUpdate()
                                        : const MyPage(),
                          ),
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
    double height = MediaQuery.of(context).size.height * 0.127;
    bool isSelected = selectedTab == index;

    return Positioned(
      top: 0, // Adjust position based on selection
      left: width * index,
      child: GestureDetector(
        onTap: () => onTabSelected(index),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: CustomFontStyle.getTextStyle(
                    context,
                    isSelected
                        ? CustomFontStyle.selectedLarge
                        : CustomFontStyle.unSelectedLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
