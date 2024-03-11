import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class EndIcon extends StatelessWidget {
  const EndIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Image.asset(AppIcons.end_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
