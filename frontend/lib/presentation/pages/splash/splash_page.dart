import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_auth.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/main.dart';
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

class _SplashPageState extends State<SplashPage> {
  late BookModel bookModel;
  bool isSaved = false;

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return false;
    final authProvider = Provider.of<AuthModel>(context, listen: false);
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if(isLogin){
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      await authProvider.login(email!, password!).then((loginStatus){
        if(loginStatus != AuthStatus.loginSuccess){
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

    // 임시 디렉토리를 가져옵니다.
    final documentDirectory = await getApplicationDocumentsDirectory();

    // 파일을 생성합니다.
    final file = File('${documentDirectory.path}/$path');

    if(!isSaved) {
      final directoryPath = file.parent.path;
      final directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      else {
        isSaved = true;
      }
    }

    file.writeAsBytesSync(response.bodyBytes);
  }


  @override
  void initState() {
    super.initState();
    // player.stop();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List bookCovers = await Provider.of<BookModel>(context, listen: false).getBookCovers();
      for(Map coverMap in bookCovers){
        String path = coverMap['coverPath'];
        final documentDirectory = await getApplicationDocumentsDirectory();
        final file = File('${documentDirectory.path}/$path');
        final fileExists = file.existsSync();

        if (fileExists) break;
        await _downloadImage(path);
      }

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
          height: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
