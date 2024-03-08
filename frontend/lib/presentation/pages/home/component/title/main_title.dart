import 'package:flutter/material.dart';



class MainTitle extends StatelessWidget {
  final String titleString;
  final double stringSize;

  const MainTitle(this.titleString, {this.stringSize = 100, super.key});

  bool containsKorean(String text) {
    RegExp koreanRegex = RegExp(r'[\u3131-\uD79D]');
    return koreanRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.38,
            child: containsKorean(titleString)
                ? Text(
                    titleString,
                    style: TextStyle(fontSize: stringSize),
                  )
                : Text(
                    titleString,
                    style: TextStyle(fontSize: stringSize, fontFamily: "Itim"),
                  ),
          ),
        ],
      ),
    );
  }
}
