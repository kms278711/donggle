import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/presentation/pages/main_screen/main_screen.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class OpenedBook extends StatefulWidget {
  final String url;
  final int bookId;

  const OpenedBook(this.url, this.bookId, {Key? key}) : super(key: key);

  @override
  State<OpenedBook> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<OpenedBook> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          String result = await DialogUtils.showCustomDialog(context,
              bookId: widget.bookId);
          if (!context.mounted) return;
          if (result == "refresh") {
            context.go(RoutePath.main3);
          }
          // DialogUtils.showCustomDialog(context, bookId: widget.bookId);
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
