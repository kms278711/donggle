import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;
import 'package:frontend/presentation/pages/card/locked_card.dart';
import 'package:frontend/presentation/pages/card/opened_card.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late domain.CardModel cardModel;
  late UserProvider userProvider;
  String accessToken = "";

  @override
  void initState() {
    super.initState();
    cardModel = Provider.of<domain.CardModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          int bookLength = cardModel.cards.length;
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
                              final card =
                                  domain.Card.fromJson(cardModel.cards[index]);
                              final url = Constant.s3BaseUrl + card.imagePath;
                              final id = card.educationId;
                              return card.isEducated ?? false
                                  ? OpenedCard(url, id)
                                  : LockedCard(url, id);
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
          )
        ],
      ),
    );
  }
}
