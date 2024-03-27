import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/home/component/book/book_detail.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class OpenedBook extends StatefulWidget {
  final String url;
  final int bookId;

  const OpenedBook(this.url, this.bookId, {Key? key}) : super(key: key);

  @override
  State<OpenedBook> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<OpenedBook> {
  late BookModel bookModel;
  late UserProvider userProvider;
  String accessToken = "";
  bool isRead = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();

      if (mounted) {
        setState(() {
          //isRead = bookModel.BookDetail['isRead'] ?? false;
          isRead = bookModel.books[widget.bookId - 1]["isRead"];
          print(isRead);
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                child: CachedNetworkImage(
                  imageUrl: widget.url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            isRead
                ? Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width * 0.02,
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
