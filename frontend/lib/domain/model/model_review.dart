import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewModel extends ChangeNotifier {

  Review myReview = Review(score: 0, content: "");

  void setMyReview(double score, String content){
    myReview.score = score;
    myReview.content = content;
    notifyListeners();
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
