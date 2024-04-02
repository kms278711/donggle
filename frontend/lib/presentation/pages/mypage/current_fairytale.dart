import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/pages/home/component/book/opened_book.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CurrentFairytale extends StatefulWidget {
  const CurrentFairytale({super.key});

  @override
  State<CurrentFairytale> createState() => _CurrentFairytaleState();
}

class _CurrentFairytaleState extends State<CurrentFairytale> {
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.748 - 20,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<String>(
              future: bookModel.getCurrentBooks(accessToken),
              // Your Future<String> function call
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the future to complete, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If the future completes with an error, display the error.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // When the future completes successfully, use the data.
                  if (snapshot.data == "Success") {
                    int bookLength = bookModel.currentBooks.length;
                    if (bookLength == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "진행 중인 동화책이 없습니다.",
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
                        final book = Book.fromJson(
                            bookModel.currentBooks[index]);
                        final path = book.path;
                        final id = book.bookId;
                        return OpenedBook(path, id);
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
    );
  }
}
