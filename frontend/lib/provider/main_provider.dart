import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  late bool _isMyPageUpdateSelected = false;
  bool get isMyPageUpdateSelected => _isMyPageUpdateSelected;

  void myPageUpdateToggle() {
    _isMyPageUpdateSelected = !_isMyPageUpdateSelected; // 값을 반전시킴
    notifyListeners();
  }
}