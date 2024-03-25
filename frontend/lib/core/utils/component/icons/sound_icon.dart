
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/sound_off_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_on_icon.dart';
import 'package:just_audio/just_audio.dart';

class SoundIcon extends StatefulWidget {
  final AudioPlayer player;

  const SoundIcon(this.player, {super.key});

  @override
  State<SoundIcon> createState() => _SoundIconState();
}

class _SoundIconState extends State<SoundIcon> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSoundOn ? widget.player.pause() : widget.player.play();
        setState(() {
          // Toggle the sound state
          isSoundOn = !isSoundOn;
        });
      },
      child: isSoundOn ? const SoundOnIcon() : const SoundOffIcon(),
    );
  }
}
