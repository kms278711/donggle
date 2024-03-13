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
      icon: img,
      padding: EdgeInsets.zero,
    );
  }
}
