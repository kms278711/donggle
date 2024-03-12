import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";
  String serverMessage = "";
  String loginMessage = "";
  bool isSame = true;
  bool isValid = true;
  bool isSignedUp = false;
  bool isFailed = false;
  bool isSignedIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  void setEmail(String email) {
    this.email = email;
    isFailed = false;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    isFailed = false;
    if (password.length < 8 || password.length > 16) {
      isValid = false;
    } else {
      isValid = true;
    }
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    isFailed = false;
    isSame = password == this.passwordConfirm;
    notifyListeners();
  }

  void resetFields() {
    emailController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    isSame = true;
    isValid = true;
  }

  void resetPassword(){
    passwordController.clear();
  }

  @override
  void dispose() {
    // Dispose controllers when the model is disposed
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      isSignedUp = true;
    } else {
      isSignedUp = false;
      isFailed = true;
      serverMessage = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/login");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      isSignedIn = true;
      prefs.setBool('isLogin', true);
      prefs.setString('email', email);
      prefs.setString('password', password);
    } else {
      isSignedIn = false;
      isFailed = true;
      serverMessage = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
    }
    notifyListeners();
  }

  Future<void> loginWithEmail(String email, String password, BuildContext context) async{
    this.email = email;
    this.password = password;
    await login(context);
  }

  Future<void> logOut(BuildContext context) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/logout");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      isSignedIn = false;
      prefs.setBool('isLogin', false);
      prefs.setString('email', '');
      prefs.setString('password', '');
    } else {
      isSignedIn = true;
    }
    notifyListeners();
  }
}
