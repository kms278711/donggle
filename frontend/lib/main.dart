import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/domain/model/model_approvals.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_cards.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/domain/model/model_profileupdate.dart';
import 'package:frontend/domain/model/model_quiz.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/provider/quiz_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/provider/main_provider.dart';

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  final cameras = await availableCameras();
  final firstCamera = cameras.last;

  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      Provider<CameraDescription>.value(value: firstCamera),
      ChangeNotifierProvider(create: (_) => MainProvider()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => QuizProvider()),
      ChangeNotifierProvider(
          create: (context) =>
              BookModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) =>
              ReviewModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) =>
              ApprovalsModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) =>
              CardModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) =>
              QuizModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) => NickNameUpdateModel(
              Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(
          create: (context) => ProfileUpdateModel(
              Provider.of<UserProvider>(context, listen: false))),
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
      playInBackground: PlayInBackground.enabled,
    );

    return StyledToast(
      locale: const Locale('ko', 'KR'),
      textStyle:
          CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
      backgroundColor: AppColors.success,
      borderRadius: BorderRadius.circular(20.0),
      textPadding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(seconds: 2),
      animDuration: const Duration(seconds: 1),
      dismissOtherOnShow: true,
      fullWidth: false,
      isHideKeyboard: true,
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
      routerConfig: globalRouter,
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
