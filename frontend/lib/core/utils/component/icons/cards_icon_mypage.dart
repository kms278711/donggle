import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CardsIconMypage extends StatefulWidget {
  const CardsIconMypage({super.key});

  @override
  State<CardsIconMypage> createState() => _CardsIconMypageState();
}

class _CardsIconMypageState extends State<CardsIconMypage> {
  // 이동하고, 정보 수정 값 false로 초기화 해서 정보수정 페이지로 안가게
  void pushAndChange() {
    context.read<MainProvider>().resetMyPageUpdate();
    context.pushReplacement(RoutePath.main1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushAndChange(),
      child: Image.asset(AppIcons.word_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
