import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PaidBook extends StatelessWidget {
  final String url;
  final int bookId;

  const PaidBook(this.url, this.bookId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Added Material widget
      color: Colors.transparent, // Avoid any undesired coloring
      child: InkWell(
        onTap: () {
          context.read<BookModel>().setCurrentBookId(bookId);
          context.read<MainProvider>().detailPageSelectionToggle();
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
