import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/presentation/routes/route_path.dart';
import 'package:frontend/presentation/provider/main_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeIconMypage extends StatefulWidget {
  const HomeIconMypage({super.key});

  @override
  State<HomeIconMypage> createState() => _HomeIconMypageState();
}

class _HomeIconMypageState extends State<HomeIconMypage> {
  // 이동하고, 정보 수정 값 false로 초기화 해서 정보수정 페이지로 안가게
  void pushAndChange() {
    context.read<MainProvider>().resetMyPageUpdate();
    context.pushReplacement(RoutePath.main0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushAndChange(),
      child: Image.asset(AppIcons.home_icon,
          width: MediaQuery.of(context).size.width * 0.05),
    );
  }
}
