import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/presentation/pages/mypage/my_review.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.748 - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.user_icon,
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '닉네임: ',
                        style: CustomFontStyle.textSmall,
                      ),
                      TextSpan(
                          text: 'mj3meal', style: CustomFontStyle.textSmallEng),
                    ],
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '이메일: ', style: CustomFontStyle.textSmall),
                      TextSpan(
                          text: 'ducco705@snu.ac.kr',
                          style: CustomFontStyle.textSmallEng),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Row(
                  children: [
                    GreenButton("정보수정"),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    GreenButton("로그아웃")
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryContainer, // Border color
                width: 10.0, // Border width
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              child: MyReview(),
            ),
          ),
        ],
      ),
    );
  }
}
