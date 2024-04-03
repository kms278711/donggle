import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateModel extends ChangeNotifier {
  final UserProvider userProvider;

  ProfileUpdateModel(this.userProvider);

  // late String profile = userProvider.getProfileImage();
  late String accessToken = userProvider.getAccessToken();
  // late String userId = userProvider.getUserId();

  // void setProfile(String profileName) {
  //   profile = 'userprofile/$userId/$profileName';
  //   notifyListeners();
  // }

  Future<String> profileUpdate(String profilePath) async {

    var uri = Uri.parse("https://j10c101.p.ssafy.io/api/users/profile-image");
    var request = http.MultipartRequest('PATCH', uri)
      ..headers['Authorization'] = "Bearer $accessToken"
      ..headers['Content-Type'] = 'multipart/form-data';

    // 파일을 추가합니다.
    if (profilePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('profileImage', profilePath));
    }

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      // 이 부분은 서버 응답에 따라 조정이 필요할 수 있습니다. 파일 경로 대신 서버에서 반환한 새로운 프로필 이미지 URL을 사용하세요.
      userProvider.setProfileImage(response.body);
      userProvider.getUserInfo();
      showToast("변경되었습니다.");
      return "Success";
    } else {
      var response = await http.Response.fromStream(streamedResponse);
      return utf8.decode(response.bodyBytes);
    }
  }
}
