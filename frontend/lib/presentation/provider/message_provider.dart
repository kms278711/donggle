import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  String message1 = "";
  String message2 = "";
  String message = "";

  void setMessage(message){
    this.message = message;
    notifyListeners();
  }

  void setMessage1(message1){
    this.message1 = message1;
    notifyListeners();
  }

  void setMessage2(message2){
    this.message2 = message2;
    notifyListeners();
  }

  void clearMessage(){
    message = "";
    message1 = "";
    message2 = "";
    notifyListeners();
  }
}
