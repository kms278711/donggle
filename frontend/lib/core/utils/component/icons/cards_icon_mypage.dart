import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

class CardsIconMypage extends StatelessWidget {
  const CardsIconMypage({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(RoutePath.main1),
      child: Image.asset(AppIcons.word_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
