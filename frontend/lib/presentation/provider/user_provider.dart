import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider{
  String _email = "";
  String _accessToken = "";
  String _refreshToken = "";
  String _nickname = "";
  String _profileImage = "";

  void setEmail(String email){
    _email = email;
  }

  void setAccessToken(String accessToken){
    _accessToken = accessToken;
  }

  void setRefreshToken(String refreshToken){
    _refreshToken = refreshToken;
  }

  void setNickname(String nickname){
    _nickname = nickname;
  }

  void setProfileImage(String profileImage){
    _profileImage = profileImage;
  }

  String getEmail(){
    return _email;
  }

  String getAccessToken(){
    return _accessToken;
  }

  String getRefreshToken(){
    return _refreshToken;
  }

  String getNickName(){
    return _nickname;
  }

  String getProfileImage(){
    return _profileImage;
  }

  Future<String> refreshToken() async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/auth/reissue");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"refreshToken": _refreshToken});

    var response = await http.post(url, headers: headers, body: body);
    print(utf8.decode(response.bodyBytes));

    if(response.statusCode == 200){
      String accessToken = json.decode(utf8.decode(response.bodyBytes))['access_token'];
      String refreshToken = json.decode(utf8.decode(response.bodyBytes))['refresh_token'];

      _accessToken = accessToken;
      _refreshToken = refreshToken;

      return "Success";
    }
    else{
      return utf8.decode(response.bodyBytes);
    }
  }

  Future<String> getUserInfo() async{
    var url = Uri.https("j10c101.p.ssafy.io", "api/users");
    final headers = {'Content-Type': 'application/json', 'Authorization' : "Bearer $_accessToken"};

    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(json.decode(utf8.decode(response.bodyBytes)));

    if(response.statusCode == 200){
      String nickname = json.decode(utf8.decode(response.bodyBytes))['nickname'] ?? "";
      String profileImage = json.decode(utf8.decode(response.bodyBytes))['profileImage'] ?? "";

      _nickname = nickname;
      _profileImage = profileImage;

      return "Success";
    }
    else{
      return utf8.decode(response.bodyBytes);
    }
  }
}
