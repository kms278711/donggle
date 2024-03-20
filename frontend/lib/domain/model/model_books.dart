import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookModel extends ChangeNotifier {
  final UserProvider userProvider;

  BookModel(this.userProvider);

  List<dynamic> books = [];
  List<dynamic> currentBooks = [];
  Book nowBook = Book(bookId: 1, isPay: false, path: "", price: 0, title: "");

  int currentBookId = 1;

  void setCurrentBookId(int currentBookId){
    this.currentBookId = currentBookId;
    notifyListeners();
  }

  Future<String> getAllBooks(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      books = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getAllBooks(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
          ['result_message'];
      return msg;
    }
  }

  Future<String> getCurrentBooks(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/mybooks");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      currentBooks = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getCurrentBooks(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
      ['result_message'];
      return msg;
    }
  }

  Future<String> getCurrentBookPurchase(String accessToken, int bookId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/purchase");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };
    var response = await http.get(url, headers: headers);

    print(json.decode(utf8.decode(response.bodyBytes)));

    if (response.statusCode == 200) {
      nowBook = Book.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getCurrentBookPurchase(userProvider.getAccessToken(), bookId);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
      ['result_message'];
      return msg;
    }
  }
}

class Book {
  final int bookId;
  final String title;
  final String? summary;
  final String path;
  final int? price;
  final bool? isPay;
  final double? averageScore;
  final List<dynamic>? reviews;
  final Map<String, dynamic>? myReview;

  Book({
    required this.bookId,
    required this.title,
    this.summary,
    required this.path,
    required this.price,
    required this.isPay,
    this.averageScore,
    this.reviews,
    this.myReview,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      title: json['title'],
      summary: json['summary'],
      path: json['coverPath'],
      price: json['price'],
      isPay: json['isPay'],
      averageScore: json['averageScore'],
      myReview: json['myBookReview'],
      reviews: json["bookReviews"],
    );
  }
}
