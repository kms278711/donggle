import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class CardModel extends ChangeNotifier {
  final UserProvider userProvider;

  CardModel(this.userProvider);

  List<dynamic> cards = [];
  late Map<String, dynamic> selectedCard = {};

  Future<String> getAllCards(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/users/educations");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      cards = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getAllCards(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
          ['result_message'];
      return msg;
    }
  }

  Future<String> getSelectedCard(String accessToken, int educationId) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/educations/$educationId");
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $accessToken"
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      selectedCard = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getAllCards(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
      ['result_message'];
      return msg;
    }
  }
}

class Card {
  final int educationId;
  final String wordName;
  final String imagePath;
  final bool isEducated;

  Card({
    required this.educationId,
    required this.wordName,
    required this.imagePath,
    required this.isEducated,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      educationId: json['educationId'],
      wordName: json['wordName'],
      imagePath: json['imagePath'],
      isEducated: json['isEducated'],
    );
  }
}
