import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/sound_off_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_on_icon.dart';

class SoundIcon extends StatefulWidget {
  final AssetsAudioPlayer assetsAudioPlayer;

  const SoundIcon(this.assetsAudioPlayer, {super.key});

  @override
  State<SoundIcon> createState() => _SoundIconState();
}

class _SoundIconState extends State<SoundIcon> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSoundOn ? widget.assetsAudioPlayer.pause() : widget.assetsAudioPlayer.play();
        setState(() {
          // Toggle the sound state
          isSoundOn = !isSoundOn;
        });
      },
      child: isSoundOn ? const SoundOnIcon() : const SoundOffIcon(),
    );
  }
}
