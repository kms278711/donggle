import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:transparent_image/transparent_image.dart';

class PaidBook extends StatelessWidget {
  final String url;
  final int bookId;

  const PaidBook(this.url, this.bookId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // Added Material widget
      color: Colors.transparent, // Avoid any undesired coloring
      child: InkWell(
        onTap: () {
          showToast(
            "구매 완료한 동화책 입니다!",
            context: context,
          );
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  // Defined in the transparent_image package
                  image: url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              left: MediaQuery.of(context).size.width * 0.04,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.9),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Text(" 구매완료 ", style: CustomFontStyle.bodyMedium,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
