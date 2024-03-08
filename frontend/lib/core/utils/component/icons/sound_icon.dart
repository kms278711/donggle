import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/sound_off_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_on_icon.dart';

class SoundIcon extends StatefulWidget {
  const SoundIcon({super.key});

  @override
  State<SoundIcon> createState() => _SoundIconState();
}

class _SoundIconState extends State<SoundIcon> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped Sound Icon");
        setState(() {
          // Toggle the sound state
          isSoundOn = !isSoundOn;
        });
      },
      child: isSoundOn
          ? const SoundOnIcon()
          : const SoundOffIcon(),
    );
  }
}
