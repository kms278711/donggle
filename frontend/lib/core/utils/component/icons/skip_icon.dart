import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/routes.dart';

class SkipIcon extends StatelessWidget {
  final VoidCallback onTap;

  const SkipIcon({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(AppIcons.skip_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
