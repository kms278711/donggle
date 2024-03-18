import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BooksDetailPay extends StatefulWidget {
  const BooksDetailPay({super.key});

  @override
  State<BooksDetailPay> createState() => _BooksDetailPayState();
}

class _BooksDetailPayState extends State<BooksDetailPay> {
  late BookModel bookModel;
  late UserProvider userProvider;
  int bookId = 0;
  String accessToken = "";
  String title = "";
  String summary = "";
  String path = "";
  String url = "";
  int price = 0;
  bool isPay = false;
  List<dynamic> reviews = [];
  var f = NumberFormat('###,###,###,###');

  @override
  void initState() {
    super.initState();

    // Schedule a callback for the end of this frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // It's now safe to perform the async operations
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      bookId = bookModel.currentBookId;

      await bookModel.getCurrentBookPurchase(accessToken, bookId);

      // Check if the widget is still mounted before updating its state
      if (mounted) {
        Book book = bookModel.nowBook;
        setState(() {
          title = book.title;
          summary = book.summary ?? "";
          path = book.path;
          url = Constant.s3BaseUrl + path;
          price = book.price ?? 0;
          isPay = book.isPay ?? false;
          reviews = book.reviews ?? [];
        });
      }
    });
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: url.isEmpty
                        ? const Center(
                            child:
                                CircularProgressIndicator()) // Show loader when URL is empty
                        : CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.25,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
                        print("clicked");
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
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: Text("줄거리",
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.titleSmall)),
                          ),
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.14),
                            // Set a maxHeight for scrolling
                            child: SingleChildScrollView(
                              child: Text(
                                summary,
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.textSmall),
                              ),
                            ),
                          ),
                        ],
                      )),
                  isPay
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.blue,
                          child: const Text("My Review"))
                  // TODO: 내 리뷰 남기기

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
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("평균평점: ",
                                  style: CustomFontStyle.getTextStyle(
                                      context, CustomFontStyle.titleSmall)),
                              // TODO: 평균평점 별로 표시하기
                            ],
                          ),
                          // TODO: 리뷰 받아와서 출력
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
