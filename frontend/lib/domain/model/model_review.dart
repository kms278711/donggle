import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ReviewModel extends ChangeNotifier {

  final UserProvider userProvider;

  ReviewModel(this.userProvider);

  Future<String> setMyReview(String accessToken, int bookId, double score, String content) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/review");

    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };

    final body = jsonEncode({
      "score": score,
      "content": content,
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return setMyReview(userProvider.getAccessToken(), bookId, score, content);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
          ['result_message'];
      return msg;
    }
  }
}

class Review {
  double score;
  String content;

  Review({
    required this.score,
    required this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      score: json['score'],
      content: json['content'],
    );
  }
}
