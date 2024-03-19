import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/core/utils/component/dialog_utils.dart';
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
            child: GreenButton("Test 시작", onPressed: () {
              DialogUtils.showCustomDialog(context,
                  contentWidget: const TestComponent());
        })),
        const BackgroundUpper(),
      ],
    );
  }
}
