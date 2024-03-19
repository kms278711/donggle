import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String _email = "";
  String _accessToken = "";
  String _refreshToken = "";
  String _nickname = "";
  String _profileImage = "";
  String _userId = "";

  void setEmail(String email) {
    _email = email;
  }

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
  }

  void setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  void setProfileImage(String profileImage) {
    _profileImage = profileImage;
    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  String getEmail() {
    return _email;
  }

  String getAccessToken() {
    return _accessToken;
  }

  String getRefreshToken() {
    return _refreshToken;
  }

  String getNickName() {
    return _nickname;
  }

  String getProfileImage() {
    return _profileImage;
  }

  String getUserId() {
    return _userId;
  }

  Future<String> refreshToken() async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/reissue");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"refreshToken": _refreshToken});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      _accessToken =
          json.decode(utf8.decode(response.bodyBytes))['access_token'];
      _refreshToken =
          json.decode(utf8.decode(response.bodyBytes))['refresh_token'];

      return "Success";
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> getUserInfo() async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/users");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $_accessToken"
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      _nickname =
          json.decode(utf8.decode(response.bodyBytes))['nickname'] ?? "";
      _profileImage =
          json.decode(utf8.decode(response.bodyBytes))['profileImage'] ?? "";

      return "Success";
    } else if (response.statusCode == 401) {
      refreshToken();
      return getUserInfo();
    } else {
      return utf8.decode(response.bodyBytes);
    }
  }
}
