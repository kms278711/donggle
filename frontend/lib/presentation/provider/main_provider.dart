import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  late bool _isMyPageUpdateSelected = false;
  late bool _isDetailPageSelected = false;
  late bool _isPurchaseHistorySelected = false;
  late bool _isSoundOn = false;


  bool get isMyPageUpdateSelected => _isMyPageUpdateSelected;
  bool get isDetailPageSeleted => _isDetailPageSelected;
  bool get isPurchaseHistorySelected => _isPurchaseHistorySelected;
  bool get isSoundOn => _isSoundOn;

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
    _isSoundOn = !_isSoundOn;
    notifyListeners();
  }

}
