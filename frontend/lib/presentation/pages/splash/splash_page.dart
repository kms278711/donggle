import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late BookModel bookModel;
  late Directory documentDirectory;
  bool isSaved = false;

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!context.mounted) return false;
    final authProvider = Provider.of<AuthModel>(context, listen: false);
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if (isLogin) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      await authProvider.login(email!, password!).then((loginStatus) {
        if (loginStatus != AuthStatus.loginSuccess) {
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

  Future<void> _downloadImage(String path) async {
    String url = Constant.s3BaseUrl + path;
    final response = await http.get(Uri.parse(url));

    // 파일을 생성합니다.
    final file = File('${documentDirectory.path}/$path');

    if (!isSaved) {
      final directoryPath = file.parent.path;
      final directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      } else {
        isSaved = true;
      }
    }

    file.writeAsBytesSync(response.bodyBytes);
  }

  AnimationController? _animationController_L;
  Animation<double>? _rotateAnimation_L;
  Animation<Offset>? _transAnimation_L;
  AnimationController? _animationController_o;
  Animation<double>? _rotateAnimation_o;
  Animation<Offset>? _transAnimation_o;
  AnimationController? _animationController_a;
  Animation<double>? _rotateAnimation_a;
  Animation<Offset>? _transAnimation_a;
  AnimationController? _animationController_d;
  Animation<double>? _rotateAnimation_d;
  Animation<Offset>? _transAnimation_d;
  AnimationController? _animationController_i;
  Animation<double>? _rotateAnimation_i;
  Animation<Offset>? _transAnimation_i;
  AnimationController? _animationController_n;
  Animation<double>? _rotateAnimation_n;
  Animation<Offset>? _transAnimation_n;
  AnimationController? _animationController_g;
  Animation<double>? _rotateAnimation_g;
  Animation<Offset>? _transAnimation_g;
  AnimationController? _animationController_dot1;
  Animation<double>? _rotateAnimation_dot1;
  Animation<Offset>? _transAnimation_dot1;
  AnimationController? _animationController_dot2;
  Animation<double>? _rotateAnimation_dot2;
  Animation<Offset>? _transAnimation_dot2;
  AnimationController? _animationController_dot3;
  Animation<double>? _rotateAnimation_dot3;
  Animation<Offset>? _transAnimation_dot3;
  AnimationController? _animationController_donggle;
  Animation<double>? _rotateAnimation_donggle;
  Animation<Offset>? _transAnimation_donggle;

  @override
  void initState() {
    super.initState();
    // player.stop();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List bookCovers = await Provider.of<BookModel>(context, listen: false).getBookCovers();
      documentDirectory = await getApplicationDocumentsDirectory();

      for (Map coverMap in bookCovers) {
        String path = coverMap['coverPath'];
        final file = File('${documentDirectory.path}/$path');
        final fileExists = file.existsSync();

        if (!fileExists) {
          await _downloadImage(path);
        }
      }

      moveScreen();
    });

    _animationController_L = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_L = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_L!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_L = Tween<Offset>(
          begin: Offset(screenWidth * 0.33, screenHeight * 0.65),
          end: Offset(screenWidth * 0.33, screenHeight * 0.55))
          .animate(_animationController_L!);
    });

    _animationController_o = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_o = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_o!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_o = Tween<Offset>(
          begin: Offset(screenWidth * 0.36, screenHeight * 0.65),
          end: Offset(screenWidth * 0.36, screenHeight * 0.55))
          .animate(_animationController_o!);
    });

    _animationController_a = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_a = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_a!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_a = Tween<Offset>(
          begin: Offset(screenWidth * 0.39, screenHeight * 0.65),
          end: Offset(screenWidth * 0.39, screenHeight * 0.55))
          .animate(_animationController_a!);
    });

    _animationController_d = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_d = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_d!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_d = Tween<Offset>(
          begin: Offset(screenWidth * 0.43, screenHeight * 0.65),
          end: Offset(screenWidth * 0.43, screenHeight * 0.55))
          .animate(_animationController_d!);
    });

    _animationController_i = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_i = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_i!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_i = Tween<Offset>(
          begin: Offset(screenWidth * 0.47, screenHeight * 0.65),
          end: Offset(screenWidth * 0.47, screenHeight * 0.55))
          .animate(_animationController_i!);
    });

    _animationController_n = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_n = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_n!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_n = Tween<Offset>(
          begin: Offset(screenWidth * 0.49, screenHeight * 0.65),
          end: Offset(screenWidth * 0.49, screenHeight * 0.55))
          .animate(_animationController_n!);
    });

    _animationController_g = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_g = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_g!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_g = Tween<Offset>(
          begin: Offset(screenWidth * 0.52, screenHeight * 0.65),
          end: Offset(screenWidth * 0.52, screenHeight * 0.55))
          .animate(_animationController_g!);
    });

    _animationController_dot1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_dot1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_dot1!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_dot1 = Tween<Offset>(
          begin: Offset(screenWidth * 0.56, screenHeight * 0.65),
          end: Offset(screenWidth * 0.56, screenHeight * 0.55))
          .animate(_animationController_dot1!);
    });

    _animationController_dot2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_dot2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_dot2!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_dot2 = Tween<Offset>(
          begin: Offset(screenWidth * 0.58, screenHeight * 0.65),
          end: Offset(screenWidth * 0.58, screenHeight * 0.55))
          .animate(_animationController_dot2!);
    });

    _animationController_dot3 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_dot3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController_dot3!,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_dot3 = Tween<Offset>(
          begin: Offset(screenWidth * 0.61, screenHeight * 0.65),
          end: Offset(screenWidth * 0.61, screenHeight * 0.55))
          .animate(_animationController_dot3!);
    });

    _animationController_donggle = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _rotateAnimation_donggle = Tween<double>(begin: 0.1, end: -0.4)
        .animate(_animationController_donggle!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      _transAnimation_donggle = Tween<Offset>(
          begin: Offset(screenWidth * 0, screenHeight * -0.05),
          end: Offset(screenWidth * 0, screenHeight * -0.05))
          .animate(_animationController_donggle!);
    });

    _animationController_L!.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 110), () {
      _animationController_o!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 220), () {
      _animationController_a!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 330), () {
      _animationController_d!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 440), () {
      _animationController_i!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 550), () {
      _animationController_n!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 660), () {
      _animationController_g!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 770), () {
      _animationController_dot1!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 880), () {
      _animationController_dot2!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 990), () {
      _animationController_dot3!.repeat(reverse: true);
    });
    _animationController_donggle!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_L!.dispose();
    _animationController_o!.dispose();
    _animationController_a!.dispose();
    _animationController_d!.dispose();
    _animationController_i!.dispose();
    _animationController_n!.dispose();
    _animationController_g!.dispose();
    _animationController_dot1!.dispose();
    _animationController_dot2!.dispose();
    _animationController_dot3!.dispose();
    _animationController_donggle!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _rotateAnimation_L!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_L!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_L != null
                      ? _transAnimation_L!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "L",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_o!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_o!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_o != null
                      ? _transAnimation_o!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "o",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_a!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_a!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_a != null
                      ? _transAnimation_a!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "a",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_d!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_d!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_d != null
                      ? _transAnimation_d!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "d",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_i!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_i!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_i != null
                      ? _transAnimation_i!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "i",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_n!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_n!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_n != null
                      ? _transAnimation_n!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "n",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_g!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_g!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_g != null
                      ? _transAnimation_g!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                "g",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_dot1!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_dot1!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_dot1 != null
                      ? _transAnimation_dot1!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                ".",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_dot2!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_dot2!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_dot2 != null
                      ? _transAnimation_dot2!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                ".",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_dot3!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_dot3!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_dot3 != null
                      ? _transAnimation_dot3!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                ".",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_dot3!,
            builder: (context, widget) {
              return FadeTransition(
                opacity: _rotateAnimation_dot3!, // 투명도 애니메이션을 적용합니다.
                child: Transform.translate(
                  offset: _transAnimation_dot3 != null
                      ? _transAnimation_dot3!.value
                      : Offset.zero,
                  child: Transform.rotate(
                    angle: 0, // 회전은 적용하지 않으므로 0으로 설정합니다.
                    child: widget,
                  ),
                ),
              );
            },
            child: DefaultTextStyle(
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.textLargeEng),
              child: const Text(
                ".",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _rotateAnimation_donggle!,
            builder: (context, widget) {
              if (_transAnimation_donggle != null) {
                return Transform.translate(
                  offset: _transAnimation_donggle!.value,
                  child: Transform.rotate(
                    angle: _rotateAnimation_donggle!.value,
                    child: widget,
                  ),
                );
              } else {
                return Container();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.donggle,
                    width: MediaQuery.of(context).size.width * 0.2),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
