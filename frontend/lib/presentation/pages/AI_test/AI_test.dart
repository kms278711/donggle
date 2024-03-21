import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/core/utils/component/icons/home_icon_main.dart';
import 'package:frontend/core/utils/component/icons/my_icon.dart';
import 'package:frontend/core/utils/component/icons/sound_icon.dart';
import 'package:frontend/main.dart';
import 'package:frontend/presentation/pages/AI_test/teachable_machine_test.dart';
import 'package:frontend/presentation/pages/home/component/background/back_ground_below.dart';
import 'package:frontend/presentation/pages/home/component/background/background_upper.dart';
import 'package:frontend/presentation/pages/AI_test/test_component.dart';
import 'package:frontend/presentation/pages/home/component/title/main_title.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AITest extends StatelessWidget {
  const AITest({super.key});

  @override
  Widget build(BuildContext context) {
    final camera = Provider.of<CameraDescription>(context, listen: false);
    return Material(
      child: Stack(
        children: [
          const BackGroundBelow(),
          const MainTitle("AI test"),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Row(
              children: [
                IconButton(
                  icon: HomeIconMain(), // replace with actual icons
                  onPressed: () {
                    context.go(RoutePath.main0);
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                const MyIcon(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                SoundIcon(assetsAudioPlayer),
              ],
            ),
          ),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GreenButton("그림 그리기 Test", onPressed: () {
                    DialogUtils.showCustomDialog(context,
                        contentWidget: const TestComponent());
                          }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height* 0.05,
                  ),
                  GreenButton("Teachable Machine Test", onPressed: () {
                    DialogUtils.showCustomDialog(context,
                        contentWidget: TeachableMachineTest(camera));
                  })
                ],
              )),
          const BackgroundUpper(),
        ],
      ),
    );
  }
}
