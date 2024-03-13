import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';

class NickNameUpdateModel extends ChangeNotifier {
  final UserProvider userProvider;

  NickNameUpdateModel(this.userProvider);

  late String nickName = userProvider.getNickName();

  final TextEditingController nickNameController = TextEditingController();

  void setNickName(String nickname) {
    nickName = nickname;
    notifyListeners();
  }
}