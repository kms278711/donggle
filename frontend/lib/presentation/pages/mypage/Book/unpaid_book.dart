import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:provider/provider.dart';

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
          /// TODO: 동화책 리뷰 화면 불러오기
          context.read<BookModel>().setCurrentBookId(widget.bookId);
          context.read<MainProvider>().detailPageSelectionToggle();
          /// TODO: 동화책 구매
          /// TODO: 책 전체 리스트 업데이트
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
