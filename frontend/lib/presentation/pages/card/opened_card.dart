import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/domain/model/model_cards.dart' as domain;
import 'package:frontend/presentation/pages/card/card_deatil.dart';
import 'package:frontend/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class OpenedCard extends StatefulWidget {
  final String url;
  final int educationId;

  const OpenedCard(this.url, this.educationId, {Key? key}) : super(key: key);

  @override
  State<OpenedCard> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<OpenedCard> {
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
    return Material(
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
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
