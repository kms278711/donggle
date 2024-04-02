import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:path_provider/path_provider.dart';

class DevelopingBook extends StatefulWidget {
  final String path;

  const DevelopingBook(this.path, {super.key});

  @override
  State<DevelopingBook> createState() => _DevelopingBookState();
}

class _DevelopingBookState extends State<DevelopingBook> {
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
          showToast("준비 중인 동화책 입니다.", backgroundColor: AppColors.error);
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
              top: MediaQuery.of(context).size.height * 0.12,
              left: MediaQuery.of(context).size.width * 0.04,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 100, 100, 0.9),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(" 준비 중 ", style: CustomFontStyle.getTextStyle(context, CustomFontStyle.bodyMedium),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
