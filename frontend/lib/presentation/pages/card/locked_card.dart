import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class LockedCard extends StatelessWidget {
  final String url;
  final int educationId;

  const LockedCard(this.url, this.educationId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material( // Added Material widget
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
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
