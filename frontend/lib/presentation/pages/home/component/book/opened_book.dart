import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class OpenedBook extends StatelessWidget {
  final String url;
  final int bookId;

  const OpenedBook(this.url, this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
    Image img = Image.network(
      url,
      fit: BoxFit.cover,
    );
    return IconButton(
      onPressed: () {
        print("[+]bookId : $bookId");
      },
      icon: Stack(
        children: [
          img,
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.7),
            width: img.width,
            height: img.height,
          ),
          Center(
            child: Image.asset(AppIcons.lock_closed, width: MediaQuery.of(context).size.width * 0.5,),
          )
        ],
      ),
      padding: EdgeInsets.zero,
    );
  }
}
