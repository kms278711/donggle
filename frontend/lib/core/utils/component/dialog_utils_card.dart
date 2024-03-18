import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/card/card_deatil.dart';

class DialogUtilsCard {
  static DialogUtilsCard _instance = new DialogUtilsCard.internal();

  DialogUtilsCard.internal();

  factory DialogUtilsCard() => _instance;

  static Future<String> showCustomCardDialog(
      BuildContext context, {
        required int educationId,
      }) async {
    final result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Builder(builder: (BuildContext context) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                color: Colors.transparent,
                child: Column(
                  children: [
                    CardDetail(educationId),
                  ],
                ),
              ),
            );
          });
        });
    return (result == null) ? "" : "refresh";
  }
}
