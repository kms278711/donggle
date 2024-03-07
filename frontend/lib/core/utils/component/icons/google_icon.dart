import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Image.asset(AppIcons.google_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
