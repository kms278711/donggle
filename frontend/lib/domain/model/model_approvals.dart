import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ApprovalsModel extends ChangeNotifier {
  final UserProvider userProvider;

  ApprovalsModel(this.userProvider);

  List<dynamic> myApprovals = [];

  /// 결제 내역 조회
  Future<String> getApprovals(String accessToken) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/approvals");

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      myApprovals = json.decode(utf8.decode(response.bodyBytes));
      return "Success";
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return getApprovals(userProvider.getAccessToken());
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }

  /// 결제 내역 저장
  Future<String> setApprovals(String accessToken, int bookId, int price) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/approvals/$bookId", {"price": price.toString()});

    final headers = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};

    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      var url2 = Uri.https("j10c101.p.ssafy.io", "api/books/$bookId/approval");
      final headers2 = {'Content-Type': 'application/json', "Authorization": "Bearer $accessToken"};
      var response2 = await http.post(url2, headers: headers2);

      if(response2.statusCode == 200){
        return "Success";
      }
      else if (response2.statusCode == 401) {
        userProvider.refreshToken();
        return setApprovals(userProvider.getAccessToken(), bookId, price);
      }
      else{
        String msg = json.decode(utf8.decode(response2.bodyBytes))['data_header']['result_message'];
        return msg;
      }
    } else if (response.statusCode == 401) {
      userProvider.refreshToken();
      return setApprovals(userProvider.getAccessToken(), bookId, price);
    } else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']['result_message'];
      return msg;
    }
  }
}

class Approval {
  int approvalId;
  int bookId;
  int price;
  String approvalDate;
  String bookTitle;

  Approval({
    required this.bookId,
    required this.price,
    required this.approvalDate,
    required this.approvalId,
    required this.bookTitle,
  });

  factory Approval.fromJson(Map<String, dynamic> json) {
    return Approval(
      bookId: json['bookId'],
      price: json['price'],
      approvalDate: json['approvalDate'],
      approvalId: json['approvalId'],
      bookTitle: json['bookTitle'],
    );
  }
}

class ApprovalData {
  String receiptId;
  String orderId;
  String purchasedAt;
  String receiptURL;
  String statusLocale;

  ApprovalData({
    required this.receiptId,
    required this.orderId,
    required this.purchasedAt,
    required this.receiptURL,
    required this.statusLocale,
  });

  factory ApprovalData.fromJson(Map<String, dynamic> json) {
    return ApprovalData(
      receiptId: json['receipt_id'],
      orderId: json['order_id'],
      purchasedAt: json['purchased_at'],
      receiptURL: json['receipt_url'],
      statusLocale: json['status_locale'],
    );
  }
}