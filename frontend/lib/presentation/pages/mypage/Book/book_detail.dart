import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BooksDetailPay extends StatefulWidget {
  const BooksDetailPay({super.key});

  @override
  State<BooksDetailPay> createState() => _BooksDetailPayState();
}

class _BooksDetailPayState extends State<BooksDetailPay> {
  late BookModel bookModel;
  int bookId = 0;
  String title = "";
  String summary = "";
  String path = "";
  String url = "";
  int price = 0;
  bool isPay = false;

  @override
  void initState() {
    super.initState();
    bookModel = Provider.of<BookModel>(context, listen: false);
    bookId = bookModel.currentBookId;
    Book book = Book.fromJson(bookModel.books[bookId - 1]);
    title = book.title;
    summary = book.summary ?? "";
    path = book.path;
    url = Constant.s3BaseUrl + path;
    price = book.price ?? 0;
    isPay = book.isPay ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: FadeInImage.memoryNetwork(
            //     placeholder: kTransparentImage,
            //     image: url,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
