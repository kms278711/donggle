import 'package:flutter/material.dart';

class LockedBook extends StatelessWidget {
  final String url;
  final int bookId;

  const LockedBook(this.url, this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30), // Set the border radius here
      child: IconButton(
        onPressed: () {
          print("[+]bookId : $bookId");
        },
        icon: Image.network(
          url,
          fit: BoxFit.cover,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
