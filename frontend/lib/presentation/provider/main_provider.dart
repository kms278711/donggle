import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  MainProvider();

  late bool _isMyPageUpdateSelected = false;
  late bool _isDetailPageSelected = false;
  late bool _isPurchaseHistorySelected = false;
  late bool isSoundOn = true;


  bool get isMyPageUpdateSelected => _isMyPageUpdateSelected;
  bool get isDetailPageSeleted => _isDetailPageSelected;
  bool get isPurchaseHistorySelected => _isPurchaseHistorySelected;

  void myPageUpdateToggle() {
    _isMyPageUpdateSelected = !_isMyPageUpdateSelected; // 값을 반전시킴
    notifyListeners();
  }

  void detailPageSelectionToggle() {
    _isDetailPageSelected = !_isDetailPageSelected;
    notifyListeners();
  }

  void purchaseHistoryToggle() {
    _isPurchaseHistorySelected = !_isPurchaseHistorySelected;
    notifyListeners();
  }

  // 초기화
  void resetMyPageUpdate() {
    _isMyPageUpdateSelected = false;
    notifyListeners(); // 상태 변경을 리스너에게 알림
  }
  void resetDetailPageSelection(){
    _isDetailPageSelected = false;
    notifyListeners();
  }

  void resetPurchaseHistory(){
    _isPurchaseHistorySelected = false;
    notifyListeners();
  }

  void soundToggle() {
    isSoundOn = !isSoundOn;
    notifyListeners();
  }
}
