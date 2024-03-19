import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class QuizWordModel extends ChangeNotifier {
  final UserProvider userProvider;

  QuizWordModel(this.userProvider);

  List<dynamic> quizzes = [];

  Future<String> getWordQuizzes(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/quizzes", {
      'theme': 'WORD',
    });
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };

    // print(accessToken);
    var response = await http.get(url, headers: headers);
    // print(json.decode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      quizzes = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getWordQuizzes(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
          ['result_message'];
      return msg;
    }
  }
}

// class Card {
//   final int educationId;
//   final String wordName;
//   final String imagePath;
//   final bool isEducated;
//
//   Card({
//     required this.educationId,
//     required this.wordName,
//     required this.imagePath,
//     required this.isEducated,
//   });
//
//   factory Card.fromJson(Map<String, dynamic> json) {
//     return Card(
//       educationId: json['educationId'],
//       wordName: json['wordName'],
//       imagePath: json['imagePath'],
//       isEducated: json['isEducated'],
//     );
//   }
// }
