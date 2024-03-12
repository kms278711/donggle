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
  // // 페이지 나가면 false로 초기화
  // @override
  // void dispose() {
  //   // Provider를 통해 상태 초기화
  //   Provider.of<MainProvider>(context, listen: false).resetMyPageUpdate();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<MainProvider>().resetMyPageUpdate();
        return true;
      },
      child: Center(
        child: GreenButton(
          "돌아가기",
          onPressed: () {
            context.read<MainProvider>().myPageUpdateToggle();
          },
        ),
      ),
    );
  }
}
