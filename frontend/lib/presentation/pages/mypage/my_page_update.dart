import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/presentation/pages/modal/signout_modal.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:provider/provider.dart';

class MyPageUpdate extends StatefulWidget {
  const MyPageUpdate({super.key});

  @override
  State<MyPageUpdate> createState() => _MyPageUpdateState();
}

class _MyPageUpdateState extends State<MyPageUpdate> {
  // // 페이지 나가면 false로 초기화
  // @override
  // void dispose() {
  //   // Provider를 통해 상태 초기화
  //   Provider.of<MainProvider>(context, listen: false).resetMyPageUpdate();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MainProvider>().resetMyPageUpdate();
        return true;
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 0, 0, 0),
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.height * 0.99,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppIcons.user_icon,
                  width: MediaQuery.of(context).size.width * 0.12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '닉네임: ',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.textLarge),
                      ),
                      TextSpan(
                          text: 'mj3meal',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textLargeEng)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '이메일: ',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textLarge)),
                      TextSpan(
                          text: 'ducco705@snu.ac.kr',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textLargeEng)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GreenButton(
                          "돌아가기",
                          onPressed: () {
                            context.read<MainProvider>().myPageUpdateToggle();
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        GreenButton(
                          "수정하기",
                          onPressed: () {
                            context.read<MainProvider>().myPageUpdateToggle();
                          },
                        ),
                      ],
                    ),
                    RedButton(
                      '회원탈퇴',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return signOut(
                              title: "회원탈퇴",
                              content: "계정을 삭제 하시겠습니까?",
                              onConfirm: () {}, // 탈퇴 코드
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
