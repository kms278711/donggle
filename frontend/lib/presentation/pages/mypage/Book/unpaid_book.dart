import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/domain/model/model_books.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UnpaidBook extends StatefulWidget {
  final String path;
  final int bookId;

  const UnpaidBook(this.path, this.bookId, {super.key});

  @override
  State<UnpaidBook> createState() => _OpenedBookState();
}

class _OpenedBookState extends State<UnpaidBook> {
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
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          context.read<BookModel>().setCurrentBookId(widget.bookId);
          context.read<MainProvider>().detailPageSelectionToggle();
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File('${documentDirectory.path}/${widget.path}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
