import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ReviewModel extends ChangeNotifier {
  final UserProvider userProvider;

  ReviewModel(this.userProvider);

}

class Review {
  final int score;
  final String content;

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
