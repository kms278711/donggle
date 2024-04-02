import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:path_provider/path_provider.dart';

class LockedCard extends StatefulWidget {
  final String path;
  final int educationId;

  const LockedCard(this.path, this.educationId, {super.key});

  @override
  State<LockedCard> createState() => _LockedCardState();
}

class _LockedCardState extends State<LockedCard> {
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
            "획득하지 못한 카드입니다.",
            context: context,
            backgroundColor: AppColors.error,
          );
        },
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Image.file(
                    File('${documentDirectory.path}/${widget.path}'),
                    fit: BoxFit.cover,
                  ),
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
