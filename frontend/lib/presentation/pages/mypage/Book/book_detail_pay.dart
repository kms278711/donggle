import 'dart:io';

import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:bootpay/config/bootpay_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/icons/close_circle.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_approvals.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/domain/model/model_review.dart';
import 'package:frontend/presentation/pages/mypage/Book/new_review_modal.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BooksDetailPay extends StatefulWidget {
  const BooksDetailPay({super.key});

  @override
  State<BooksDetailPay> createState() => _BooksDetailPayState();
}

class _BooksDetailPayState extends State<BooksDetailPay> {
  late BookModel bookModel;
  late UserProvider userProvider;
  late ReviewModel reviewModel;
  late ApprovalsModel approvalsModel;
  Payload payload = Payload();
  String webApplicationId = dotenv.env['BOOTPAY_WEB']!;
  String androidApplicationId = dotenv.env['BOOTPAY_ANDROID']!;
  String iosApplicationId = dotenv.env['BOOTPAY_IOS']!;
  String restApplicationId = dotenv.env['BOOTPAY_REST']!;
  String pk = dotenv.env['BOOTPAY_PRIVATE']!;

  int bookId = 0;
  String accessToken = "";
  String title = "";
  String summary = "";
  String path = "";
  String nickname = "";
  String email = "";
  int price = 0;
  double averageScore = 0.0;
  bool isPay = false;
  Book book = Book(bookId: 0, title: '', path: '', price: 0, isPay: false);
  bool isReviewed = false;
  List<dynamic> reviews = [];
  Review myReview = Review(score: 0, content: "");
  var f = NumberFormat('###,###,###,###');
  late Directory documentDirectory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Schedule a callback for the end of this frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // It's now safe to perform the async operations
      bookModel = Provider.of<BookModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      reviewModel = Provider.of<ReviewModel>(context, listen: false);
      approvalsModel = Provider.of<ApprovalsModel>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      bookId = bookModel.currentBookId;

      await bookModel.getCurrentBookPurchase(accessToken, bookId);
      documentDirectory = await getApplicationDocumentsDirectory();

      // Check if the widget is still mounted before updating its state
      if (mounted) {
        Book book = bookModel.nowBook;
        setState(() {
          title = book.title;
          summary = book.summary ?? "";
          path = book.path;
          price = book.price ?? 0;
          isPay = book.isPay ?? false;
          averageScore = book.averageScore ?? 0.0;
          myReview = Review.fromJson(book.myReview ?? {'score': 0.0, 'content': ""});
          reviews = book.reviews ?? [];
          isReviewed = myReview.score != 0.0 || myReview.content != "";

          bookModel = Provider.of<BookModel>(context, listen: false);
          userProvider = Provider.of<UserProvider>(context, listen: false);

          nickname = userProvider.getNickName();
          email = userProvider.getEmail();

          bootpayReqeustDataInit(nickname, email);

          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
            child: const CircularProgressIndicator()))
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                    child: IconButton(
                      icon: CloseCircle(
                        size: MediaQuery.of(context).size.width * 0.035,
                      ),
                      onPressed: () {
                        context.read<MainProvider>().resetDetailPageSelection();
                      },
                    )),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.23,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File('${documentDirectory.path}/${path}'),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                            ),
                          ),
                          isPay
                              ? Container()
                              : Text(
                                  "${f.format(price)}원",
                                  style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleSmall),
                                ),
                          isPay
                              ? GreenButton("구매완료", onPressed: () {
                                  showToast(
                                    "이미 구매한 동화책입니다.",
                                    backgroundColor: AppColors.error,
                                  );
                                })
                              : GreenButton("구매하기", onPressed: () {
                                  goBootpayTest(context);
                                }),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.22,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      child: Text("줄거리",
                                          style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleSmallSmall)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.14),
                                      // Set a maxHeight for scrolling
                                      child: SingleChildScrollView(
                                        child: Text(
                                          summary,
                                          style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryContainer, // Border color
                                  width: 10.0, // Border width
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                child: Column(
                                  children: [
                                    isPay
                                        ? Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height * 0.14,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                              width: 3,
                                              color: AppColors.primaryContainer,
                                            ))),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("내 리뷰",
                                                    style: CustomFontStyle.getTextStyle(
                                                        context, CustomFontStyle.titleSmallSmall)),
                                                Row(
                                                  children: [
                                                    //
                                                    isReviewed
                                                        ? Row(
                                                            children: [
                                                              RatingBar.builder(
                                                                initialRating: myReview.score,
                                                                minRating: 1,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: true,
                                                                ignoreGestures: true,
                                                                itemCount: 5,
                                                                itemSize: MediaQuery.of(context).size.width * 0.02,
                                                                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                                                itemBuilder: (context, _) => const Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                ),
                                                                onRatingUpdate: (double value) {},
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width * 0.01,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width * 0.33,
                                                                height: MediaQuery.of(context).size.height * 0.05,
                                                                child: SingleChildScrollView(
                                                                  scrollDirection: Axis.vertical,
                                                                  child: Text(
                                                                    myReview.content,
                                                                    style: CustomFontStyle.getTextStyle(
                                                                        context, CustomFontStyle.textMoreSmall),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : GreenButton(
                                                            "내 리뷰 등록하기",
                                                            onPressed: () {
                                                              DialogUtils.showCustomDialog(context,
                                                                  contentWidget: NewReviewModal(onModalClose: () {
                                                                setState(() {
                                                                  Book book = bookModel.nowBook;
                                                                  averageScore = book.averageScore ?? 0.0;
                                                                  myReview = Review.fromJson(
                                                                      book.myReview ?? {'score': 0.0, 'content': ""});
                                                                  reviews = book.reviews ?? [];
                                                                  isReviewed = true;
                                                                  isPay = true;
                                                                });
                                                              }));
                                                            },
                                                            textStyle: CustomFontStyle.getTextStyle(
                                                                context, CustomFontStyle.textMoreSmall),
                                                          )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Row(
                                      children: [
                                        Text("평균평점: ",
                                            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleSmallSmall)),
                                        RatingBar.builder(
                                          initialRating: averageScore,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          itemCount: 5,
                                          itemSize: MediaQuery.of(context).size.width * 0.02,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (double value) {},
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: isPay
                                          ? MediaQuery.of(context).size.width * 0.10
                                          : MediaQuery.of(context).size.width * 0.17,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: reviews.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RatingBar.builder(
                                                initialRating: reviews[index]['score'],
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                ignoreGestures: true,
                                                itemCount: 5,
                                                itemSize: MediaQuery.of(context).size.width * 0.02,
                                                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (double value) {},
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.02,
                                              ),
                                              Flexible(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: reviews[index]['content'],
                                                    style:
                                                        CustomFontStyle.getTextStyle(context, CustomFontStyle.textMoreSmall),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
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
              ],
            ),
          );
  }

  bootpayReqeustDataInit(String nickname, String email) {
    payload.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId = androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id

    payload.pg = 'kcp';
    payload.methods = ['card', 'phone', 'kakaopay', 'payco', 'naverpay'];

    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    User user = User(); // 구매자 정보
    user.id = "";
    user.username = nickname;
    user.email = email;
    user.area = "";
    user.phone = "";
    user.addr = '';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutter';

    if (BootpayConfig.ENV == -1) {
      payload.extra?.redirectUrl = 'https://dev-api.bootpay.co.kr/v2';
    } else if (BootpayConfig.ENV == -2) {
      payload.extra?.redirectUrl = 'https://stage-api.bootpay.co.kr/v2';
    } else {
      payload.extra?.redirectUrl = 'https://api.bootpay.co.kr/v2';
    }

    BootpayConfig.IS_FORCE_WEB = true;
    BootpayConfig.DISPLAY_TABLET_FULLSCREEN = true;
    BootpayConfig.DISPLAY_WITH_HYBRID_COMPOSITION = true;

    payload.user = user as User?;
    payload.extra = extra;
  }

  void goBootpayTest(BuildContext context) {
    payload.orderName = title;
    payload.price = price.toDouble();
    String result = "";

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      onIssued: (String data) {
        debugPrint("------------onIssued: $data");
      },
      onError: (String data) {
        showToast(data, backgroundColor: AppColors.error);
      },
      onConfirmAsync: (String data) async {
        return true;
      },
      onDone: (String data) async {
        debugPrint("-------onDone: $data");
        result = await approvalsModel.setApprovals(accessToken, bookId, price);

        if (result == "Success") {
          showToast("구매가 완료되었습니다.");
          if (!context.mounted) return;
          setState(() {
            isPay = true;
          });
          context.read<MainProvider>().resetDetailPageSelection();
        } else {
          showToast(result, backgroundColor: AppColors.error);
        }
      },
      onClose: () {
        if (mounted) {
          Bootpay().removePaymentWindow();
          Navigator.of(context).pop();
        }
      },
    );
  }
}
