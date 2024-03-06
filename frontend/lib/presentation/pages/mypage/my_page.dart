import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/utils/component/icons/cards_icon.dart';
import 'package:frontend/core/utils/component/icons/home_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppIcons.background),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.01,
              child: Row(
                children: [
                  const HomeIcon(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const CardsIcon(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const SoundIcon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
