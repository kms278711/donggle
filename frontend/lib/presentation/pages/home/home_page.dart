import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppIcons.background), // 배경 이미지
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent, // 배경색을 투명으로 설정
      ),
    );
  }
}
