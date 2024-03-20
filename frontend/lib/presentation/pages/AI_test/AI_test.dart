import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
import 'package:frontend/presentation/pages/AI_test/teachable_machine_test.dart';
import 'package:frontend/presentation/pages/home/component/background/back_ground_below.dart';
import 'package:frontend/presentation/pages/home/component/background/background_upper.dart';
import 'package:frontend/presentation/pages/AI_test/test_component.dart';

class AITest extends StatelessWidget {
  const AITest({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGroundBelow(),
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
                      contentWidget: const TeachableMachineTest());
                })
              ],
            )),
        const BackgroundUpper(),
      ],
    );
  }
}
