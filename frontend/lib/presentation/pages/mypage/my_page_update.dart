import 'package:flutter/material.dart';
import 'package:frontend/core/utils/component/buttons/green_button.dart';

class MyPageUpdate extends StatefulWidget {
  final bool isUpdateSelected;

  const MyPageUpdate({
    super.key,
    required this.isUpdateSelected,
  });

  @override
  State<MyPageUpdate> createState() => _MyPageUpdateState();
}

class _MyPageUpdateState extends State<MyPageUpdate> {
  late bool isUpdateSelected;

  @override
  void initState() {
    super.initState();
    isUpdateSelected = widget.isUpdateSelected; // 상위 위젯에서 전달받은 초기 데이터
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: GreenButton(
      "정보수정",
      onPressed: () {
        isUpdateSelected != isUpdateSelected;
      },
    ),);
  }
}