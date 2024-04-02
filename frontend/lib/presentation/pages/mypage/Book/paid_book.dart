import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PaidBook extends StatefulWidget {
  final String path;
  final int bookId;

  const PaidBook(this.path, this.bookId, {super.key});

  @override
  State<PaidBook> createState() => _PaidBookState();
}

class _PaidBookState extends State<PaidBook> {
  late Directory documentDirectory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
      // Added Material widget
      color: Colors.transparent, // Avoid any undesired coloring
      child: InkWell(
        onTap: () {
          context.read<BookModel>().setCurrentBookId(widget.bookId);
          context.read<MainProvider>().detailPageSelectionToggle();
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File('${documentDirectory.path}/${widget.path}'),
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => const CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              left: MediaQuery.of(context).size.width * 0.04,
              child: Container(
                decoration:
                    BoxDecoration(color: const Color.fromRGBO(217, 217, 217, 0.9), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  " 구매완료 ",
                  style: CustomFontStyle.getTextStyle(context, CustomFontStyle.bodyMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
