
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/sound_off_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_on_icon.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class SoundIcon extends StatefulWidget {
  final AudioPlayer player;

  const SoundIcon(this.player, {super.key});

  @override
  State<SoundIcon> createState() => _SoundIconState();
}

class _SoundIconState extends State<SoundIcon> {

  late MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        widget.player.playing ? widget.player.pause() : widget.player.play();
        setState(() {
          // Toggle the sound state
          mainProvider.soundToggle();
          // isSoundOn = !widget.player.playing;
        });
      },
      child: widget.player.playing ? const SoundOnIcon() : const SoundOffIcon(),
    );
  }
}
