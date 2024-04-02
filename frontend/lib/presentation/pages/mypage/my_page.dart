import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:package_info_plus/package_info_plus.dart';
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
  String userId = "";
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

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
    userId = userProvider.getUserId();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if(mounted) {
        setState(() {
          packageName = packageInfo.packageName;
          version = packageInfo.version;
          buildNumber = packageInfo.buildNumber;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.748 - 20,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: Constant.s3BaseUrl + profileImage,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '닉네임: ',
                                style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
                              ),
                              TextSpan(
                                  text: nickName, style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '이메일: ', style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall)),
                              TextSpan(
                                  text: email, style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmallEng)),
                            ],
                          ),
                        ),
                      ],
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
                          onPressed: () async {
                            AuthStatus logoutStatus = await auth.logOut(accessToken);
                            if (logoutStatus == AuthStatus.logoutSuccess) {
                              showToast('로그아웃에 성공하였습니다!');
                              if (context.mounted) {
                                context.go(RoutePath.login);
                              }
                            } else {
                              showToast('로그아웃에 실패하였습니다.');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryContainer, // Border color
                    width: MediaQuery.of(context).size.width * 0.008, // Border width
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.03)),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: MediaQuery.of(context).size.height,
                  child: const MyReview(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * 0.02,
            child: Text(
              "donggle_S10P22C101_$version+$buildNumber",
              style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmallSmallEng),
            ),
          )
        ],
      ),
    );
  }
}
