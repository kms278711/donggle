import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/component/icons/circle_back_icon.dart';
import 'package:frontend/core/utils/component/loading_screen.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:frontend/presentation/routes/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  final int bookId;

  const BookDetail(this.bookId, {super.key});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late BookModel bookModel;
  late Directory documentDirectory;
  int bookId = 0;
  String bookTitle = "";
  String bookCover = "";
  int bookPage = 0;
  int bookTotalPage = 0;
  List educations = [];
  String url = "";
  int index = 0;
  bool isDone = false;
  bool isLoading = true;
  List<dynamic> bookPageImagePath = [];
  bool isRead = false;
  late MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

  Future<void> _downloadImage(String path) async {
    String url = Constant.s3BaseUrl + path;
    final response = await http.get(Uri.parse(url));

    // 파일을 생성합니다.
    final file = File('${documentDirectory.path}/$path');
    final directoryPath = file.parent.path;
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    // 파일에 데이터를 씁니다.
    file.writeAsBytesSync(response.bodyBytes);
  }

  @override
  void initState() {
    super.initState();
    // bookModel = Provider.of<BookModel>(context, listen: false);
    // bookTitle = bookModel.books[widget.bookId - 1]['title'];
    // bookCover = bookModel.books[widget.bookId - 1]['coverPath'];
    // url = Constant.s3BaseUrl + bookCover;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadDataAsync();
    });
  }

  Future loadDataAsync() async {
    bookModel = Provider.of<BookModel>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var accessToken = userProvider.getAccessToken();

    await bookModel.getBookDetail(accessToken, widget.bookId);
    documentDirectory = await getApplicationDocumentsDirectory();

    if (mounted) {
      bookPageImagePath = bookModel.BookDetail['bookPageImagePathList'];
      for (String imagePath in bookPageImagePath) {
        final file = File('${documentDirectory.path}/$imagePath');
        final fileExists = file.existsSync();

        if (!fileExists) {
          await _downloadImage(imagePath);
        }
      }
      for (String soundPath in bookModel.BookDetail['bookSoundPathList']) {
        final file = File('${documentDirectory.path}/$soundPath');
        final fileExists = file.existsSync();

        if (!fileExists) {
          await _downloadImage(soundPath);
        }
      }

      for (Map word in bookModel.BookDetail['educationList']) {
        final file = File('${documentDirectory.path}/${word['imagePath']}');
        final fileExists = file.existsSync();

        if (!fileExists) {
          await _downloadImage(word['imagePath']);
        }
      }
      if (mounted) {
        // 데이터 로딩 완료 후 상태 업데이트
        setState(() {
          bookTitle = bookModel.BookDetail['title'];
          bookCover = bookModel.BookDetail['coverImagePath'];
          bookTotalPage = bookModel.BookDetail['totalPage'];
          bookPage = bookModel.BookDetail['processPage'];
          educations = bookModel.BookDetail['educationList'];
          bookPageImagePath = bookModel.BookDetail['bookPageImagePathList'];
          url = Constant.s3BaseUrl + bookCover;
          index = bookModel.progresses.indexWhere((progress) => progress.bookId == widget.bookId);
          isDone = bookModel.progresses[index].isDone;
          int idx = bookModel.books.indexWhere((book) => book['bookId'] == widget.bookId);
          isRead = bookModel.books[idx]["isRead"];

          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : DefaultTextStyle(
            style: CustomFontStyle.getTextStyle(context, CustomFontStyle.titleSmall),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      child: Image.asset(AppIcons.bottle, width: MediaQuery.of(context).size.width * 0.35),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    child: Image.file(
                      File('${documentDirectory.path}/$bookCover'),
                      fit: BoxFit.cover,
                      // memCacheWidth: 500,
                      width: MediaQuery.of(context).size.width * 0.25,
                      // placeholder: (context, url) => const CircularProgressIndicator(),
                      // errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.18,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: EdgeInsets.zero,
                      child: GridView.count(
                        crossAxisCount: 2,
                        // 한 줄에 2개의 항목을 표시
                        crossAxisSpacing: MediaQuery.of(context).size.width * 0.01,
                        // 가로 간격
                        mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                        // 세로 간격
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(educations.length, (index) {
                          var education = educations[index];
                          return Transform.rotate(
                            angle: index % 2 == 0 ? 350 * pi / 180 : 10 * pi / 180,
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.file(
                                    File('${documentDirectory.path}/${education["imagePath"]}'),
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height * 0.3,
                                  ),
                                ),
                                Positioned(
                                  bottom: MediaQuery.of(context).size.height * 0.055,
                                  left: 0,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.185,
                                    child: Text(
                                      education["wordName"],
                                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textSmall),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.75,
                  left: MediaQuery.of(context).size.width * 0.12,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.27,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GreenButton("처음부터", onPressed: () {
                          Navigator.of(context).pop();
                          mainProvider.isSoundOn = false;
                          bookModel.progresses[index].isDone = false;
                          globalRouter.pushReplacement('/bookProgress/${widget.bookId}/1/0');
                        }),
                        if (bookPage != 0 && isDone == false)
                          GreenButton("이어하기", onPressed: () {
                            mainProvider.isSoundOn = false;
                            Navigator.of(context).pop();
                            // bookModel.progresses[index].isDone = false;
                            globalRouter.pushReplacement('/bookProgress/${widget.bookId}/$bookPage/0');
                          }),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.115,
                  right: MediaQuery.of(context).size.width * 0.06,
                  child: GreenButton("문제풀기", onPressed: () {
                    // Navigator.of(context).pop("refresh");
                    // context.go(RoutePath.main3);
                    if (isRead) {
                      Navigator.of(context).pop();
                      globalRouter.pushReplacement('/main/3/${widget.bookId}');
                    } else {
                      showToast('동화책을 읽고 진행해주세요', backgroundColor: AppColors.error);
                    }
                    // globalRouter.pushReplacement(RoutePath.main3.replaceAll(":bookId", widget.bookId.toString()));
                    // Navigator.of(context).pop();
                    // context.pushReplacement(RoutePath.main3);
                  }),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: donggleTalk(situation: "BOOK"),
                ),
              ],
            ),
          );
  }
}
