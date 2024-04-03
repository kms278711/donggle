import 'dart:convert';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail,
  logoutSuccess,
  logoutFail,
  signOutSuccess,
  signOutFail,
  inputError,
}

enum LoginPlatform { kakao, google, naver, none }

class AuthModel {
  final UserProvider userProvider;
  final MessageProvider messageProvider;

  AuthModel(this.userProvider, this.messageProvider);

  Future<AuthStatus> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      // 여기서 적절한 처리를 하거나 오류 메시지를 반환할 수 있습니다.
      // 예를 들어, 빈 문자열이나 null을 전달하기보다는 오류 상태를 반환하거나,
      // 사용자에게 유효하지 않은 입력을 알리는 등의 처리를 할 수 있습니다.
      return AuthStatus.inputError; // inputError는 유효하지 않은 입력을 나타내는 상태로 가정
    }

    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return AuthStatus.registerSuccess;
    } else {
      String serverMessage =
          json.decode(utf8.decode(response.bodyBytes))['data_header']
              ['result_message'];
      messageProvider.setMessage2(serverMessage);
      showToast(serverMessage, backgroundColor: AppColors.error);
      return AuthStatus.registerFail;
    }
    // var url = Uri.https("j10c101.p.ssafy.io", "api/auth/signup");
    // final headers = {'Content-Type': 'application/json'};
    // final body = jsonEncode({"email": email, "password": password});
    // late http.Response response;
    //
    // if (email.isNotEmpty && password.isNotEmpty) {
    //   response = await http.post(url, headers: headers, body: body);
    // }
    //
    // if (response.statusCode == 200) {
    //   return AuthStatus.registerSuccess;
    // } else {
    //   String serverMessage =
    //   json.decode(utf8.decode(response.bodyBytes))['data_header']
    //   ['result_message'];
    //   messageProvider.setMessage2(serverMessage);
    //   return AuthStatus.registerFail;
    // }
  }

  Future<AuthStatus> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      // 여기서 적절한 처리를 하거나 오류 메시지를 반환할 수 있습니다.
      // 예를 들어, 빈 문자열이나 null을 전달하기보다는 오류 상태를 반환하거나,
      // 사용자에게 유효하지 않은 입력을 알리는 등의 처리를 할 수 있습니다.
      return AuthStatus.inputError; // inputError는 유효하지 않은 입력을 나타내는 상태로 가정
    }

    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/login");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      String accessToken =
          json.decode(utf8.decode(response.bodyBytes))['access_token'];
      String refreshToken =
          json.decode(utf8.decode(response.bodyBytes))['refresh_token'];

      userProvider.setEmail(email);
      userProvider.setAccessToken(accessToken);
      userProvider.setRefreshToken(refreshToken);

      prefs.setBool('isLogin', true);
      prefs.setString('email', email);
      prefs.setString('password', password);

      userProvider.getUserInfo();

      return AuthStatus.loginSuccess;
    } else {
      String serverMessage =
          json.decode(utf8.decode(response.bodyBytes))['data_header']
              ['result_message'];
      messageProvider.setMessage1(serverMessage);
      return AuthStatus.loginFail;
    }
  }

  Future<AuthStatus> logOut(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/logout");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      userProvider.setEmail("");
      userProvider.setAccessToken("");
      userProvider.setRefreshToken("");

      prefs.setBool('isLogin', false);
      prefs.setString('email', '');
      prefs.setString('password', '');

      return AuthStatus.logoutSuccess;
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return logOut(userProvider.getAccessToken());
    } else {
      return AuthStatus.logoutFail;
    }
  }

  Future<AuthStatus> signOut(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/users");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      userProvider.setEmail("");
      userProvider.setAccessToken("");
      userProvider.setRefreshToken("");

      prefs.setBool('isLogin', false);
      prefs.setString('email', '');
      prefs.setString('password', '');

      return AuthStatus.signOutSuccess;
    } else if (response.statusCode == 400) {
      userProvider.refreshToken();
      return logOut(userProvider.getAccessToken());
    } else {
      return AuthStatus.signOutFail;
    }
  }
}
