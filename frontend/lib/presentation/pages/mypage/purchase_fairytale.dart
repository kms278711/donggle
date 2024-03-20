import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/mypage/Book/paid_book.dart';
import 'package:frontend/presentation/pages/mypage/Book/unpaid_book.dart';
import 'package:provider/provider.dart';

class PurchaseFairytale extends StatefulWidget {
  const PurchaseFairytale({super.key});

  @override
  State<PurchaseFairytale> createState() => _PurchaseFairytaleState();
}

class _PurchaseFairytaleState extends State<PurchaseFairytale> {
  late BookModel bookModel;

  @override
  void initState() {
    super.initState();
    bookModel = Provider.of<BookModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.748 - 20,
          child: Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (BuildContext context) {
                    int bookLength = bookModel.books.length;
                    if (bookLength == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "구매 가능한 동화책이 없습니다.",
                            // Use the data from the snapshot
                            textAlign: TextAlign.center,
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.unSelectedLarge),
                          ),
                        ],
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.height * 0.05,
                      ),
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemCount: bookLength,
                      itemBuilder: (context, index) {
                        final book = Book.fromJson(bookModel.books[index]);
                        final url = Constant.s3BaseUrl + book.path;
                        final id = book.bookId;
                        return book.isPay ?? false
                            ? PaidBook(url, id)
                            : UnpaidBook(url, id);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            right: MediaQuery.of(context).size.width * 0.015,
            child: GreenButton("구매내역", onPressed: () {})),
      ],
    );
  }
}
