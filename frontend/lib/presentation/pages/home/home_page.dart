import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/loading_screen.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/home/component/book/locked_book.dart';
import 'package:frontend/presentation/pages/home/component/book/opened_book.dart';
import 'package:frontend/presentation/pages/splash/splash_page.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'component/title/main_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BookModel bookModel;
  late UserProvider userProvider;
  String accessToken = "";

  @override
  void initState() {
    super.initState();
    bookModel = Provider.of<BookModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle("Books"),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.11,
            left: MediaQuery.of(context).size.height * 0.16,
            right: MediaQuery.of(context).size.width * 0.09,
            bottom: MediaQuery.of(context).size.width * 0.07,
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<String>(
                    future: bookModel.getAllBooks(accessToken),
                    // Your Future<String> function call
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While waiting for the future to complete, show a loading spinner.
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // If the future completes with an error, display the error.
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // When the future completes successfully, use the data.
                        if (snapshot.data == "Success") {
                          int bookLength = bookModel.books.length;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing:
                                  MediaQuery.of(context).size.height * 0.05,
                            ),
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: bookLength,
                            itemBuilder: (context, index) {
                              final book =
                                  Book.fromJson(bookModel.books[index]);
                              final path = book.path;
                              final id = book.bookId;
                              final isPay = book.isPay ?? false;
                              int idx = bookModel.progresses.indexWhere(
                                  (progress) => progress.bookId == id);
                              if (idx == -1 && isPay) {
                                bookModel.progresses
                                    .add(Progress(bookId: id, isDone: false));
                              }
                              return isPay ?? false
                                  ? OpenedBook(path, id)
                                  : LockedBook(path, id);
                            },
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!,
                                // Use the data from the snapshot
                                textAlign: TextAlign.center,
                                style: CustomFontStyle.getTextStyle(
                                    context, CustomFontStyle.unSelectedLarge),
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SplashPage(),
          //         ),
          //       );
          //     },
          //     child: Text(
          //       'splahs',
          //       style: CustomFontStyle.textLarge,
          //     ),
          // )
        ],
      ),
    );
  }
}
