import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UnpaidBook extends StatefulWidget {
  final String url;
  final int bookId;

  const UnpaidBook(this.url, this.bookId, {Key? key}) : super(key: key);

  @override
  State<UnpaidBook> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<UnpaidBook> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          print("[*] TODO: Pay for book");
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
