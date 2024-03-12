import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:provider/provider.dart';

class MyPageUpdate extends StatefulWidget {
  const MyPageUpdate({super.key});

  @override
  State<MyPageUpdate> createState() => _MyPageUpdateState();
}

class _MyPageUpdateState extends State<MyPageUpdate> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GreenButton(
        "돌아가기",
        onPressed: () {
          context.read<MainProvider>().myPageUpdateToggle();
        },
      ),
    );
  }
}
