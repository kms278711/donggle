import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/donggle_talk.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;
import 'package:frontend/presentation/pages/card/locked_card.dart';
import 'package:frontend/presentation/pages/card/opened_card.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late domain.CardModel cardModel;
  late UserProvider userProvider;
  late Directory documentDirectory;
  String accessToken = "";
  bool _isLoading = true;

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
    setState(() {
      _isLoading = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cardModel = Provider.of<domain.CardModel>(context, listen: false);
      userProvider = Provider.of<UserProvider>(context, listen: false);
      accessToken = userProvider.getAccessToken();
      await cardModel.getAllCards(accessToken);
      documentDirectory = await getApplicationDocumentsDirectory();

      for (Map card in cardModel.cards) {
        final file = File('${documentDirectory.path}/${card['imagePath']}');
        final fileExists = file.existsSync();

        if (!fileExists) {
          await _downloadImage(card['imagePath']);
        }
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Stack(
          children: [
            CircularProgressIndicator(),
            MainTitle("Notes"),
          ],
        )
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                const MainTitle("Notes"),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.11,
                  left: MediaQuery.of(context).size.height * 0.16,
                  right: MediaQuery.of(context).size.width * 0.09,
                  bottom: MediaQuery.of(context).size.width * 0.07,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<String>(
                          future: cardModel.getAllCards(accessToken),
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
                                int bookLength = cardModel.cards.length;
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  itemCount: bookLength,
                                  itemBuilder: (context, index) {
                                    final card = domain.Card.fromJson(cardModel.cards[index]);
                                    final path = card.imagePath;
                                    final id = card.educationId;
                                    final word = card.wordName;
                                    return card.isEducated ? OpenedCard(path, id, word) : LockedCard(path, id);
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
                                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.unSelectedLarge),
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
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  right: 0,
                  child: const donggleTalk(situation: "WORDLIST"),
                ),
              ],
            ),
          );
  }
}
