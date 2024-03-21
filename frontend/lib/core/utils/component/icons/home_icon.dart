import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Image.asset(AppIcons.home_icon,
          width: MediaQuery.of(context).size.width * 0.1),
    );
  }
}
