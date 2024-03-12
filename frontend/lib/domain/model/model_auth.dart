import 'dart:convert';

import 'package:frontend/presentation/provider/message_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail,
  logoutSuccess,
  logoutFail,
}

class AuthModel{
  final UserProvider userProvider;
  final MessageProvider messageProvider;
  AuthModel(this.userProvider, this.messageProvider);

  Future<AuthStatus> signUp(String email, String password) async {


    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return AuthStatus.registerSuccess;
    } else {
      String serverMessage = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      messageProvider.setMessage2(serverMessage);
      return AuthStatus.registerFail;
    }
  }

  Future<AuthStatus> login(String email, String password) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/login");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      String accessToken = json.decode(utf8.decode(response.bodyBytes))['access_token'];
      String refreshToken = json.decode(utf8.decode(response.bodyBytes))['refresh_token'];

      userProvider.setEmail(email);
      userProvider.setAccessToken(accessToken);
      userProvider.setRefreshToken(refreshToken);

      prefs.setBool('isLogin', true);
      prefs.setString('email', email);
      prefs.setString('password', password);

      userProvider.getUserInfo();

      return AuthStatus.loginSuccess;
    } else {
      String serverMessage = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      messageProvider.setMessage1(serverMessage);
      return AuthStatus.loginFail;
    }
  }

  Future<AuthStatus> logOut(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/logout");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {

      userProvider.setEmail("");
      userProvider.setAccessToken("");
      userProvider.setRefreshToken("");

      prefs.setBool('isLogin', false);
      prefs.setString('email', '');
      prefs.setString('password', '');

      print("logout success");
      return AuthStatus.logoutSuccess;
    } else {
      return AuthStatus.logoutFail;
    }
  }
}