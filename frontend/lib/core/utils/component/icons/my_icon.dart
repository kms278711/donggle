import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushReplacement(RoutePath.myPage),
      child: Image.asset(AppIcons.my_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
