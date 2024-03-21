import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  Payload payload = Payload();
  String webApplicationId = dotenv.env['BOOTPAY_WEB']!;
  String androidApplicationId = dotenv.env['BOOTPAY_ANDROID']!;
  String iosApplicationId = dotenv.env['BOOTPAY_IOS']!;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}