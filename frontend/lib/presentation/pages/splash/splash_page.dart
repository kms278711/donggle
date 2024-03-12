import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerProvider = Provider.of<RegisterFieldModel>(context, listen: false);
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if(isLogin){
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      await registerProvider.loginWithEmail(email!, password!, context).then((_){
        if(registerProvider.isSignedIn){
          //TODO: 로그인 성공 시 해야하는 것? 예를들면 access Token 저장이라던지...
        }else{
          isLogin = false;
          prefs.setBool('isLogin', false);
        }
      });
    }
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) {
      if (isLogin) {
        context.go(RoutePath.main0);
      } else {
        context.go(RoutePath.login);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), (){
      moveScreen();
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppIcons.donggle,
          height: 270,
        ),
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
