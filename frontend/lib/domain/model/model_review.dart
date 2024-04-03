import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ReviewModel extends ChangeNotifier {
  final UserProvider userProvider;

  ReviewModel(this.userProvider);

  List<dynamic> myReviews = [];

  /// 책 리뷰 등록
  Future<String> setMyReview(String accessToken, int bookId, double score, String content) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/review");

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

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
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 내가 쓴 리뷰 조회
  Future<String> getMyReviews(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/my-reviews");

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      myReviews = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getMyReviews(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 내가 쓴 리뷰 수정
  Future<String> editMyReview(String accessToken, int bookId, double score, String content) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/review");

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    final body = jsonEncode({
      "score": score,
      "content": content,
    });

    var response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return editMyReview(userProvider.getAccessToken(), bookId, score, content);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 내가 쓴 리뷰 삭제
  Future<String> deleteMyReview(String accessToken, int bookId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/review");

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return deleteMyReview(userProvider.getAccessToken(), bookId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }
}

class Review {
  int? bookId;
  String? title;
  String? coverPath;
  double score;
  String content;

  Review({
    this.bookId,
    this.title,
    this.coverPath,
    required this.score,
    required this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      bookId: json['bookId'],
      title: json['title'],
      coverPath: json['coverPath'],
      score: json['score'],
      content: json['content'],
    );
  }
}
