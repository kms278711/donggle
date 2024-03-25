import 'package:flutter/material.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static Future<String> showCustomDialog(
    BuildContext context, {
    required Widget contentWidget,
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
                padding: const EdgeInsets.all(20),
                color: Colors.transparent,
                child: Column(
                  children: [
                    contentWidget,
                  ],
                ),
              ),
            );
          });
        });
    return (result == null) ? "" : "refresh";
  }
}
