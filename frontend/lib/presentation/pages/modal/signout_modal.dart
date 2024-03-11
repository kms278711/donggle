import 'package:flutter/material.dart';

class MyModal extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;

  const MyModal({super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text("확인"),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // 모달 닫기
          },
        ),
        TextButton(
          child: Text("취소"),
          onPressed: () => Navigator.of(context).pop(), // 모달 닫기
        ),
      ],
    );
  }
}

// RedButton('회원탈퇴', onPressed: () {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return MyModal(
// title: "제목",
// content: "내용입니다.",
// onConfirm: () {},
// );
// },
// );
// })