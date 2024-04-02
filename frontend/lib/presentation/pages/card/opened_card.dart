import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;
import 'package:frontend/presentation/pages/card/card_detail.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class OpenedCard extends StatefulWidget {
  final String path;
  final int educationId;
  final String word;

  const OpenedCard(this.path, this.educationId, this.word, {super.key});

  @override
  State<OpenedCard> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<OpenedCard> {
  late domain.CardModel cardModel;
  late UserProvider userProvider;
  late Directory documentDirectory;
  String accessToken = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    cardModel = Provider.of<domain.CardModel>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      documentDirectory = await getApplicationDocumentsDirectory();
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          // String result = await DialogUtils.showCustomDialog(context,
          //     bookId: widget.bookId);
          // if (!context.mounted) return;
          // if (result == "refresh") {
          //   context.go(RoutePath.main3);
          // }
          cardModel.getSelectedCard(accessToken, widget.educationId);
          DialogUtils.showCustomDialog(context, contentWidget: CardDetail(widget.educationId));
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File('${documentDirectory.path}/${widget.path}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.035,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.195,
                  child: Text(
                    widget.word,
                    textAlign: TextAlign.center,
                    style: CustomFontStyle.getTextStyle(context, CustomFontStyle.textMediumLarge),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
