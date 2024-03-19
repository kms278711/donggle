import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class TestIcon extends StatelessWidget {
  const TestIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RoutePath.aiTest),
      child: Image.asset(AppIcons.test_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
