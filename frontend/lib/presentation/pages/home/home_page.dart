import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_books.dart';
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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const MainTitle("Books"),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.11,
            left: MediaQuery.of(context).size.height * 0.16,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder<String>(
                future: bookModel.getAllBooks(accessToken),
                // Your Future<String> function call
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // If the future completes with an error, display the error.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // When the future completes successfully, use the data.
                    if (snapshot.data == "Success") {
                      return ListView.builder(
                        itemCount: bookModel.books.length,
                        itemBuilder: (context, index) {
                          final book = Book.fromJson(bookModel.books[index]);
                          return ListTile(
                            title: Text(book.title, style: CustomFontStyle.textSmall,),
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!, // Use the data from the snapshot
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
          )
        ],
      ),
    );
  }
}
