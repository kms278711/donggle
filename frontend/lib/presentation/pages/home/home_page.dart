import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/icons/cards_icon.dart';
import 'package:frontend/core/utils/component/icons/my_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/presentation/pages/home/component/background/background_screen.dart';

import 'component/title/main_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const BackgroundScreen(),
          const MainTitle("Books"),
          // 책 리스트 받아와서 여기서 출력
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Row(
              children: [
                const CardsIcon(),
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
