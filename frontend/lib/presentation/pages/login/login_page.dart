import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignup = false;

  void signUpToggle() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  void initState() {
    super.initState();
    // player.stop();
  }

  @override
  Widget build(BuildContext context) {
    var message = Provider.of<MessageProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                DefaultTextStyle(
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.titleLarge),
                  child: const Text('동  글  이'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Text(
                    isSignup ? message.message2 : message.message1,
                    style: CustomFontStyle.getTextStyle(
                        context, CustomFontStyle.errorMedium),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const EmailInput(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const PasswordInput(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                AnimatedCrossFade(
                  firstChild: const Column(
                    children: [
                      PasswordConfirmInput(),
                    ],
                  ),
                  secondChild: Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                  ),
                  crossFadeState: isSignup
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                AnimatedCrossFade(
                  firstChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SignupButton(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<RegisterFieldModel>(context,
                                  listen: false)
                              .resetFields();
                          message.setMessage2('');
                          signUpToggle();
                        },
                        child: DefaultTextStyle(
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textLarge),
                          child: const Text('취소'),
                        ),
                      ),
                    ],
                  ),
                  secondChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LoginButton(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<RegisterFieldModel>(context,
                                  listen: false)
                              .resetFields();
                          message.setMessage1('');
                          signUpToggle();
                        },
                        child: DefaultTextStyle(
                          style: CustomFontStyle.getTextStyle(
                              context, CustomFontStyle.textLarge),
                          child: const Text('회원가입'),
                        ),
                      ),
                    ],
                  ),
                  crossFadeState: isSignup
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              right: MediaQuery.of(context).size.width * 0.01,
              child: SoundIcon(player),
            )
          ],
        ),
      ),
    );
  }
}

///-----------------------------------------------------------------------------------------///
class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: registerField.emailController,
            onChanged: (email) {
              registerField.setEmail(email);
            },
            keyboardType: TextInputType.emailAddress,
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.textSmall),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.038, 0, 0, 0),
              icon: Text(
                'Email',
                style: CustomFontStyle.getTextStyle(
                    context, CustomFontStyle.textMediumLarge),
              ),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

///-----------------------------------------------------------------------------------------///
class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: true);

    return Container(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: registerField.passwordController,
            onChanged: (password) {
              registerField.setPassword(password);
            },
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.textSmall),
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.072, 0, 0, 0),
                icon: Text(
                  'PW',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.textMediumLarge),
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}

///-----------------------------------------------------------------------------------------///
class PasswordConfirmInput extends StatelessWidget {
  const PasswordConfirmInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: true);

    return Container(
      width: MediaQuery.of(context).size.width * 0.47,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: registerField.passwordConfirmController,
            onChanged: (passwordConfirm) {
              registerField.setPasswordConfirm(passwordConfirm);
            },
            style: CustomFontStyle.getTextStyle(
                context, CustomFontStyle.textSmall),
            obscureText: true,
            // showCursor: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
                icon: Text(
                  'PW 확인',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.textMediumLarge),
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}

///-----------------------------------------------------------------------------------------///
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);
    final auth = Provider.of<AuthModel>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        AuthStatus loginStatus =
            await auth.login(registerField.email, registerField.password);

        if (context.mounted) {
          if (registerField.email.isEmpty) {
            showToast('이메일을 입력해주세요.', backgroundColor: AppColors.error);
          } else if (registerField.password.isEmpty) {
            showToast('비밀번호를 입력해주세요.', backgroundColor: AppColors.error);
          } else if (loginStatus == AuthStatus.loginSuccess) {
            showToast('로그인에 성공하였습니다!');
            context.go(RoutePath.main0);
          } else {
            showToast("로그인에 실패했습니다.", backgroundColor: AppColors.error);
            registerField.resetPassword();
          }
        }

        // if (loginStatus == AuthStatus.loginSuccess) {
        //   showToast('로그인에 성공하였습니다!');
        //   context.go(RoutePath.main0);
        // } else {
        //   showToast("로그인에 실패했습니다.", backgroundColor: AppColors.error);
        //   registerField.resetPassword();
        // }
      },
      child: DefaultTextStyle(
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textLarge),
        child: const Text('로그인'),
      ),
    );
  }
}

///-----------------------------------------------------------------------------------------///
class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: true);
    final auth = Provider.of<AuthModel>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        if (registerField.isValid &&
            (registerField.password == registerField.passwordConfirm)) {
          AuthStatus registerStatus =
              await auth.signUp(registerField.email, registerField.password);

          if (registerField.email.isEmpty) {
            showToast('이메일을 입력해주세요.', backgroundColor: AppColors.error);
          } else if (registerField.password.isEmpty) {
            showToast('비밀번호를 입력해주세요.', backgroundColor: AppColors.error);
          } else if (registerField.passwordConfirm.isEmpty) {
            showToast('비밀번호를 입력해주세요.', backgroundColor: AppColors.error);
          } else if (registerStatus == AuthStatus.registerSuccess) {
            await auth.login(registerField.email, registerField.password);
            showToast('회원가입에 성공하였습니다!');
            if (!context.mounted) return;
            context.go(RoutePath.main0);
          } else {
            registerField.resetFields();
          }

          // if (registerStatus == AuthStatus.registerSuccess) {
          //   await auth.login(registerField.email, registerField.password);
          //   showToast('회원가입에 성공하였습니다!');
          //   context.go(RoutePath.main0);
          // } else {
          //   registerField.resetFields();
          // }
        }
      },
      child: DefaultTextStyle(
        style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textLarge),
        child: const Text('회원가입'),
      ),
    );
  }
}
