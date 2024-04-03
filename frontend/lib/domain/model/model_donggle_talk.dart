import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonggleTalkModel extends ChangeNotifier {

  Map dongglesTalk = {};

  Future<String> getDonggleTalk(String situation) async {
    var url = Uri.https("j10c101.p.ssafy.io", "api/donggle/message", {
      'situation': situation,
    });
    final headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      dongglesTalk = json.decode(utf8.decode(response.bodyBytes));
      notifyListeners();
      return "Success";
    }  else {
      String msg = json.decode(utf8.decode(response.bodyBytes))['data_header']
      ['result_message'];
      return msg;
    }
  }
}