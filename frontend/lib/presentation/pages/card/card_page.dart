import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/home_icon.dart';
import 'package:frontend/core/utils/component/icons/my_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/presentation/pages/home/component/background/background_screen.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const BackgroundScreen(),
          const MainTitle("Notes"),
          // 도감 리스트 받아와서 여기서 출력
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Row(
              children: [
                const HomeIcon(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const MyIcon(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const SoundIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
