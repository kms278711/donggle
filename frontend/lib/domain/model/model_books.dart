import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookModel extends ChangeNotifier {
  List<dynamic> books = [];

  Future<String> getAllBooks(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/books");
    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    print(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
        books = json.decode(utf8.decode(response.bodyBytes));
        return "Success";
    } else {
      return json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
    }
  }
}

class Book{
  final int bookId;
  final String title;
  final String? summary;
  final String? path; // Assuming it can be null based on your JSON
  final String price;
  final bool isPay;

  Book({
    required this.bookId,
    required this.title,
    required this.summary,
    this.path,
    required this.price,
    required this.isPay,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      title: json['title'],
      summary: json['summary'],
      path: json['path'],
      price: json['price'],
      isPay: json['isPay'],
    );
  }
}