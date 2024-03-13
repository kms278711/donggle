import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/home/component/book/book_detail.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;


  static void showCustomDialog(BuildContext context,
      {required String title,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required int bookId,
        required Function okBtnFunction}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Builder(
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: Column(
                      children: [

                        BookDetail(bookId),

                      ],
                    ),
                  ),
                );
              }
          );
        });
  }
}