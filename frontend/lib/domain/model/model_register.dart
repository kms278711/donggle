import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/message_provider.dart';

class RegisterFieldModel extends ChangeNotifier {
  final MessageProvider messageProvider;

  RegisterFieldModel(this.messageProvider);

  String email = "";
  String password = "";
  String passwordConfirm = "";
  String serverMessage = "";
  String loginMessage = "";
  // bool isSame = true;
  bool isValid = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  bool isValidEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void setEmail(String email) {
    if (isValidEmail(email) || email.isEmpty) {
      this.email = email;
      messageProvider.setMessage2("");
    } else {
      this.email = email;
      messageProvider.setMessage2("이메일 형식이 올바르지 않습니다.");
    }
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    if ((password.isNotEmpty && password.length < 8) || password.length > 16) {
      isValid = false;
      messageProvider.setMessage2("비밀번호는 8자 이상, 16자 이하로 설정해주세요.");
    } else {
      isValid = true;
      if (this.password != passwordConfirm) {
        messageProvider.setMessage2("비밀번호가 일치하지 않습니다.");
      }
      // if (isSame || passwordConfirm.isEmpty) {
      //   messageProvider.setMessage2("");
      // } else {
      //   messageProvider.setMessage2("비밀번호가 일치하지 않습니다.");
      // }
    }
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    // isSame = password == this.passwordConfirm;
    if(passwordConfirm.isEmpty){
      messageProvider.setMessage2("");
    } else if (passwordConfirm != password) {
      messageProvider.setMessage2("비밀번호가 일치하지 않습니다.");
    } else if (isValid) {
      messageProvider.setMessage2("");
    }
    // else if (!isSame) {
    //   messageProvider.setMessage2("비밀번호가 일치하지 않습니다.");
    // } else if (isValid) {
    //   messageProvider.setMessage2("");
    // } else {
    //   messageProvider.setMessage2("비밀번호는 8자 이상, 16자 이하로 설정해주세요.");
    // }
    notifyListeners();
  }

  void resetFields() {
    emailController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    setEmail('');
    setPassword('');
    setPasswordConfirm('');
    // isSame = true;
    isValid = true;
    // notifyListeners();
  }

  void resetPassword() {
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    // Dispose controllers when the model is disposed
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }
}
