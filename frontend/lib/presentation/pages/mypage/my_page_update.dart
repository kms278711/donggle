import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/presentation/pages/modal/nickname_update_modal.dart';
import 'package:frontend/presentation/pages/modal/signout_modal.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyPageUpdate extends StatefulWidget {
  const MyPageUpdate({super.key});

  @override
  State<MyPageUpdate> createState() => _MyPageUpdateState();
}

class _MyPageUpdateState extends State<MyPageUpdate> {
  late AuthModel auth;
  late UserProvider userProvider;
  String accessToken = "";
  String nickName = "";
  String email = "";
  String profileImage = "";

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    userProvider.getUserInfo();
    nickName = userProvider.getNickName();
    email = userProvider.getEmail();
    profileImage = userProvider.getProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MainProvider>().resetMyPageUpdate();
        return true;
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.1, 0, 0, 0),
        // height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      AppIcons.user_icon,
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    GreenButton(
                      "수정하기",
                      onPressed: () {
                        context.read<MainProvider>().myPageUpdateToggle();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '닉네임: ',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.textLarge),
                          ),
                          TextSpan(
                              text: nickName,
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.textLarge)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    GreenButton(
                      '수정하기',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const nickNameUpdateModal(
                              title: "닉네임 수정",
                              input: NickNameInput(), // 수정 코드
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    GreenButton(
                      "돌아가기",
                      onPressed: () {
                        context.read<MainProvider>().myPageUpdateToggle();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.03,
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
