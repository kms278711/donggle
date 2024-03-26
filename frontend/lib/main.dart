import 'dart:async';
import 'dart:io';

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
import 'package:frontend/domain/model/model_donggle_talk.dart';
import 'package:frontend/domain/model/model_nicknameupdate.dart';
import 'package:frontend/domain/model/model_profileupdate.dart';
import 'package:frontend/domain/model/model_quiz.dart';
import 'package:frontend/domain/model/model_register.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/provider/quiz_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:frontend/presentation/provider/main_provider.dart';

late AudioPlayer player;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  final cameras = await availableCameras();
  final firstCamera = cameras.last;

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  player = AudioPlayer();

  final audioSource = AudioSource.uri(
    Uri.parse('asset:///assets/music/background.mp3'),
    tag: const MediaItem(
      // Specify a unique ID for each media item:
      id: '1',
      title: "background music",
    ),
  );

  await player.setAudioSource(audioSource);

  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      Provider<CameraDescription>.value(value: firstCamera),
      ChangeNotifierProvider(create: (_) => MainProvider()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => QuizProvider()),
      ChangeNotifierProvider(create: (_) => DonggleTalkModel()),
      ChangeNotifierProvider(create: (context) => BookModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => ReviewModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => ApprovalsModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => CardModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => QuizModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => NickNameUpdateModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => ProfileUpdateModel(Provider.of<UserProvider>(context, listen: false))),
      ChangeNotifierProvider(create: (context) => RegisterFieldModel(Provider.of<MessageProvider>(context, listen: false))),
      ProxyProvider2<UserProvider, MessageProvider, AuthModel>(
        update: (_, userProvider, messageProvider, previousAuthModel) => AuthModel(userProvider, messageProvider),
      ),
    ],
    child: const MyApp(),
  ));

  WidgetsBinding.instance.addObserver(_Handler());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return StyledToast(
      locale: const Locale('ko', 'KR'),
      textStyle: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
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
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      player.play(); // Audio player is a custom class with resume and pause static methods
    } else {
      player.pause();
    }
  }
}
