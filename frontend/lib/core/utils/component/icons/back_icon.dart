import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback onTap;

  const BackIcon({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(AppIcons.back_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
