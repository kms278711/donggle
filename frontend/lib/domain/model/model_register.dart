import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";
  String serverMessage = "";
  bool isSame = true;
  bool isValid = true;
  bool isSignedUp = false;
  bool isFailed = false;
  bool isLoggedIn = false;

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
    isSame = this.password == passwordConfirm;
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
}
