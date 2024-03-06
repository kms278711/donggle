import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String titleString;
  final double stringSize;

  const MainTitle(this.titleString, {this.stringSize = 100, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Text(titleString,
              style: TextStyle(fontSize: stringSize),
            ),
          ),
        ],
      ),
    );
  }
}
