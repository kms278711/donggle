import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  late bool _isMyPageUpdateSelected = false;

  bool get isMyPageUpdateSelected => _isMyPageUpdateSelected;

  void myPageUpdateToggle() {
    _isMyPageUpdateSelected = !_isMyPageUpdateSelected; // 값을 반전시킴
    notifyListeners();
  }

  // 초기화
  void resetMyPageUpdate() {
    _isMyPageUpdateSelected = false;
    notifyListeners(); // 상태 변경을 리스너에게 알림
  }
}
