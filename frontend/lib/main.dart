import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/provider/main_provider.dart';

late AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MainProvider()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
      Provider(create: (_) => UserProvider()),
      ChangeNotifierProvider(
          create: (context) => RegisterFieldModel(
              Provider.of<MessageProvider>(context, listen: false))),
      ProxyProvider2<UserProvider, MessageProvider, AuthModel>(
        update: (_, userProvider, messageProvider, previousAuthModel) =>
            AuthModel(userProvider, messageProvider),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    assetsAudioPlayer.open(
      Audio("assets/music/background.mp3"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      autoStart: false, //자동 시작 여부
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
    );

    return StyledToast(
      locale: const Locale('ko', 'KR'),
      //You have to set this parameters to your locale
      textStyle:
          CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
      //Default text style of toast
      backgroundColor: AppColors.success,
      //Background color of toast
      borderRadius: BorderRadius.circular(20.0),
      //Border radius of toast
      textPadding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      //The padding of toast text
      toastPositions: StyledToastPosition.bottom,
      //The position of toast
      toastAnimation: StyledToastAnimation.fade,
      //The animation type of toast
      reverseAnimation: StyledToastAnimation.fade,
      //The reverse animation of toast (display When dismiss toast)
      curve: Curves.fastOutSlowIn,
      //The curve of animation
      reverseCurve: Curves.fastLinearToSlowEaseIn,
      //The curve of reverse animation
      duration: const Duration(seconds: 2),
      //The duration of toast showing, when set [duration] to Duration.zero, toast won't dismiss automatically.
      animDuration: const Duration(seconds: 1),
      //The duration of animation(including reverse) of toast
      dismissOtherOnShow: true,
      //When we show a toast and other toast is showing, dismiss any other showing toast before.
      fullWidth: false,
      //Whether the toast is full screen (subtract the horizontal margin)
      isHideKeyboard: true,
      //Is hide keyboard when toast show
      isIgnoring: true,
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
