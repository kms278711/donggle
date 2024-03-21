import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/core/utils/constant/constant.dart';
import 'package:frontend/domain/model/model_approvals.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/model_books.dart';

class ApprovalCard extends StatefulWidget {
  final Approval approval;

  const ApprovalCard(this.approval, {super.key});

  @override
  State<ApprovalCard> createState() => _ApprovalCardState();
}

class _ApprovalCardState extends State<ApprovalCard> {
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    String coverPath =
        Provider.of<BookModel>(context, listen: false).books[widget.approval.bookId - 1]['coverPath'];
    String url = Constant.s3BaseUrl + coverPath;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: ShapeDecoration(
        color: const Color.fromRGBO(240, 240, 240, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 15,
            offset: Offset(15, 15),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.approval.bookTitle,
                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.bodyMedium),
                    ),
                    Text(
                      "${f.format(widget.approval.price)}원",
                      style: CustomFontStyle.getTextStyle(context, CustomFontStyle.bodySmall),
                    ),
                  ],
                ),

                Text(
                  "${widget.approval.approvalDate.split('T')[0]} 구매완료",
                  style: CustomFontStyle.getTextStyle(context, CustomFontStyle.bodySmall),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
