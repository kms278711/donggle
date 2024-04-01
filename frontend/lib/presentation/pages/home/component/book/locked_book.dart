import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class LockedBook extends StatelessWidget {
  final String url;
  final int bookId;

  const LockedBook(this.url, this.bookId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material( // Added Material widget
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
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  memCacheWidth: 450,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
