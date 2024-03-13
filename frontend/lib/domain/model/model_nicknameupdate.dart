import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<String> nickNameUpdate(String nickname) async {
    print(nickname);
    print(accessToken);
    var url = Uri.https(
        "j10c101.p.ssafy.io", "api/users/nickname", {"nickname": nickname});
    print(url);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    var response = await http.patch(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('변경성공');
      return "Success";
    } else {
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    }
  }
}
