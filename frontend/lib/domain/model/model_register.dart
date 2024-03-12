import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";
  bool isSame = true;
  bool isValid = true;
  bool isSignedUp = false;
  bool isLoggedIn = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
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
    var url = Uri.parse("http://j10c101.p.ssafy.io:8082/api/auth/signup");
    final body = '{"email": "${this.email}", "password": "${this.password}"}';

    var response = await http.post(url, body: body);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
        isSignedUp = true;
      } else {
        isSignedUp = false;
      }
    }
}
