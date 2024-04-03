import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/loading_screen.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/home/component/book/book_detail.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class OpenedBook extends StatefulWidget {
  final String path;
  final int bookId;

  const OpenedBook(this.path, this.bookId, {super.key});

  @override
  State<OpenedBook> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<OpenedBook> {
  late BookModel bookModel;
  late UserProvider userProvider;
  late Directory documentDirectory;
  String accessToken = "";
  bool isRead = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      documentDirectory = await getApplicationDocumentsDirectory();

      if (mounted) {
        setState(() {
          //isRead = bookModel.BookDetail['isRead'] ?? false;
          isRead = bookModel.books[widget.bookId - 1]["isRead"];
          _isLoading = false;
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          bookModel.getBookDetail(accessToken, widget.bookId);
          DialogUtils.showCustomDialog(context, contentWidget: BookDetail(widget.bookId));
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File('${documentDirectory.path}/${widget.path}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            isRead
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    //right: MediaQuery.of(context).size.width * 0.02,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Image.asset("assets/images/donggle_quiz.png")))
                : Container(),
          ],
        ),
      ),
    );
  }
}
