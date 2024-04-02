import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/mypage/Book/developing_book.dart';
import 'package:frontend/presentation/pages/mypage/Book/paid_book.dart';
import 'package:frontend/presentation/pages/mypage/Book/unpaid_book.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PurchaseFairytale extends StatefulWidget {
  const PurchaseFairytale({super.key});

  @override
  State<PurchaseFairytale> createState() => _PurchaseFairytaleState();
}

class _PurchaseFairytaleState extends State<PurchaseFairytale> {
  late BookModel bookModel;
  late UserProvider userProvider;
  String accessToken = "";

  @override
  void initState() {
    super.initState();
    bookModel = Provider.of<BookModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();

      await bookModel.getAllBooks(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookModel = context.watch<BookModel>();
    int bookLength = bookModel.books.length;

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
                    if (bookLength == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "구매 가능한 동화책이 없습니다.",
                            // Use the data from the snapshot
                            textAlign: TextAlign.center,
                            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
                          ),
                        ],
                      );
                    }
                    return ClipRRect(
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.01),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: MediaQuery.of(context).size.height * 0.04,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: bookLength,
                        itemBuilder: (context, index) {
                          final book = Book.fromJson(bookModel.books[index]);
                          final path = book.path;
                          final id = book.bookId;
                          if (index >= 2) return DevelopingBook(path);
                          return book.isPay ?? false ? PaidBook(path, id) : UnpaidBook(path, id);
                        },
                      ),
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
            child: GreenButton("구매내역", onPressed: () {
              context.read<MainProvider>().purchaseHistoryToggle();
            })),
      ],
    );
  }
}
