import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/utils/component/loading_screen.dart';
import 'package:path_provider/path_provider.dart';

class LockedBook extends StatefulWidget {
  final String path;
  final int bookId;

  const LockedBook(this.path, this.bookId, {Key? key}) : super(key: key);

  @override
  State<LockedBook> createState() => _LockedBookState();
}

class _LockedBookState extends State<LockedBook> {
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
    return _isLoading ? const CircularProgressIndicator() : Material( // Added Material widget
      color: Colors.transparent, // Avoid any undesired coloring
      child: InkWell(
        onTap: () {
          showToast(
            "마이페이지에서 동화책을 구매해주세요.",
            duration: const Duration(seconds: 3),
            context: context,
            backgroundColor: AppColors.error,
          );
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File('${documentDirectory.path}/${widget.path}'),
                  fit: BoxFit.cover,
                  // memCacheWidth: 450,
                  // placeholder: (context, url) => const CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(0, 0, 0, 0.7),
                ),
                width: MediaQuery.of(context).size.width * 0.165,
              ),
            ),
            Center(
              child: Image.asset(
                AppIcons.lock_closed,
                width: 60,
                height: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
