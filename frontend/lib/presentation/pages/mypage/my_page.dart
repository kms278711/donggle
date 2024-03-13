import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/presentation/pages/mypage/my_review.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
                Image.network(
                  Constant.s3BaseUrl + profileImage,
                  width: MediaQuery.of(context).size.width * 0.1,
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
                            context, CustomFontStyle.textSmall),
                      ),
                      TextSpan(
                          text: nickName,
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textSmall)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '이메일: ',
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textSmall)),
                      TextSpan(
                          text: email,
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textSmallEng)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Row(
                  children: [
                    GreenButton(
                      "정보수정",
                      onPressed: () {
                        context.read<MainProvider>().myPageUpdateToggle();
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    GreenButton(
                      "로그아웃",
                      onPressed: () async{
                        AuthStatus logoutStatus = await auth.logOut(accessToken);
                        if(logoutStatus == AuthStatus.logoutSuccess){
                          showToast('로그아웃에 성공하였습니다!');
                          context.go(RoutePath.login);
                        }else{
                          showToast('로그아웃에 실패하였습니다.');
                        }

                      },
                    )
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
