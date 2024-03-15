import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/drawing_board/flutter_drawing_board.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:intl/intl.dart';
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
  var f = NumberFormat('###,###,###,###');

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: url,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                isPay
                    ? Container()
                    : Text(
                        "${f.format(price)}원",
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.titleSmall),
                      ),
                isPay
                    ? GreenButton("구매완료", onPressed: () {
                      showToast(
                        "이미 구매한 동화책입니다.",
                        backgroundColor: AppColors.error,
                      );
                })
                    : GreenButton("구매하기", onPressed: () {
                      /// TODO: 결제로 넘어가기
                }),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text("Summary")),
                  isPay
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.blue,
                          child: Text("My Review"))
                      : Container(),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: isPay
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryContainer, // Border color
                          width: 10.0, // Border width
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                        child: Text("Full Review "),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
