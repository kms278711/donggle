import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/buttons/red_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/presentation/pages/login/login_page.dart';
import 'package:frontend/presentation/pages/modal/nickname_update_modal.dart';
import 'package:frontend/presentation/pages/modal/profileimage_update_modal.dart';
import 'package:frontend/presentation/pages/modal/signout_modal.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

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
    final currentNickName =
        Provider.of<UserProvider>(context, listen: true).getNickName();
    final currentProfile =
        Provider.of<UserProvider>(context, listen: true).getProfileImage();

    return Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.1, 0, 0, 0),
      // height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text(Constant.s3BaseUrl + currentProfile),
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: Constant.s3BaseUrl + currentProfile,
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  GreenButton(
                    "수정하기",
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return const profileImageUpdateModal(
                            title: "프로필 사진 변경",
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
                            text: currentNickName,
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
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return const nickNameUpdateModal(
                            title: "닉네임 수정",
                            input: NickNameInput(), // 수정 코드
                          );
                        },
                      ).then(
                        (value) {
                          Provider.of<NickNameUpdateModel>(context,
                                  listen: false)
                              .resetFields();
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
                  Builder(
                    builder: (newContext) {
                      return RedButton(
                        '회원탈퇴',
                        onPressed: () {
                          showDialog(
                            context: newContext,
                            builder: (BuildContext dialogContext) {
                              return signOut(
                                title: "회원탈퇴",
                                content: "계정을 삭제 하시겠습니까?",
                                onConfirm: () async {
                                  AuthStatus signOutStatus =
                                      await auth.signOut(accessToken);
                                  if (signOutStatus ==
                                      AuthStatus.signOutSuccess) {
                                    Navigator.of(dialogContext).pop();
                                    showToast('탈퇴가 완료되었습니다.');
                                    newContext.go(RoutePath
                                        .login); // 새로운 BuildContext를 사용
                                  } else {
                                    showToast('들어올땐 마음대로지만 나갈땐 아닙니다.');
                                  }
                                },
                              );
                            },
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
    );
  }
}
