import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class DevelopingBook extends StatelessWidget {
  final String url;

  const DevelopingBook(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                child: const Text(" 준비 중 ", style: CustomFontStyle.bodyMedium,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
