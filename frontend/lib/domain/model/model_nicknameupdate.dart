import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class NickNameUpdateModel extends ChangeNotifier {
  final UserProvider userProvider;

  NickNameUpdateModel(this.userProvider);

  late String nickName = userProvider.getNickName();
  late String accessToken = userProvider.getAccessToken();

  final TextEditingController nickNameController = TextEditingController();

  void setNickName(String nickname) {
    nickName = nickname;
    notifyListeners();
  }

  void resetFields() {
    nickNameController.clear();
  }

  Future<String> nickNameUpdate(String nickname) async {
    var url = Uri.https(
        "j10c101.p.ssafy.io", "api/users/nickname", {"nickname": nickname});
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    var response = await http.patch(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {

      userProvider.setNickname(nickname);
      userProvider.getUserInfo();
      resetFields();
      showToast("변경되었습니다.");

      return "Success";
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }
}
