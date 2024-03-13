import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/icons/circle_back_icon.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookDetail extends StatefulWidget {
  int bookId;

  BookDetail(this.bookId, {super.key});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late BookModel bookModel;
  String bookTitle = "";
  String bookCover = "";
  String url = "";

  @override
  void initState() {
    super.initState();
    bookModel = Provider.of<BookModel>(context, listen: false);
    bookTitle = bookModel.books[widget.bookId - 1]['title'];
    bookCover = bookModel.books[widget.bookId - 1]['coverPath'];
    url = Constant.s3BaseUrl + bookCover;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: CustomFontStyle.titleSmall,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Image.asset(
                AppIcons.parchment,
                height: MediaQuery.of(context).size.height * 0.88,
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            top: 0,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(AppIcons.bottle,
                    width: MediaQuery.of(context).size.width * 0.35),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.32,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.25,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bookTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.115,
            left: MediaQuery.of(context).size.width * 0.045,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleBackIcon(
                size: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.13,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.25,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.12,
            child: Row(
              children: [
                GreenButton("처음부터", onPressed: () {}),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                GreenButton("이어하기", onPressed: () {}),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.115,
            right: MediaQuery.of(context).size.width * 0.06,
            child: GreenButton("문제풀기", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
