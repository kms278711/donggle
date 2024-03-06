import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class SoundIcon extends StatelessWidget {
  const SoundIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Image.asset(AppIcons.sound_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
