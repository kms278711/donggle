import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class SoundOnIcon extends StatelessWidget {
  const SoundOnIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppIcons.sound_icon,
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.width * 0.05,
    );
  }
}
