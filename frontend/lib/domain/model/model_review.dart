import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class ReviewModel extends ChangeNotifier {
  final UserProvider userProvider;

  ReviewModel(this.userProvider);

}