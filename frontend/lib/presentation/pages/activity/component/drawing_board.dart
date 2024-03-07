import 'package:flutter/material.dart';
import 'package:frontend/core/drawing_board/flutter_drawing_board.dart';

class DrawingBoardPage extends StatefulWidget {
  const DrawingBoardPage({super.key});

  @override
  State<DrawingBoardPage> createState() => _TestPageState();
}

class _TestPageState extends State<DrawingBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 10,
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(217, 217, 217, 0.9)),
            child: SizedBox(
              height: 600,
              width: 1000,
              child: DrawingBoard(
                background: Container(width: 1000, height: 500, color: Colors.white),
                showDefaultActions: true, /// Enable default action options
                showDefaultTools: true,   /// Enable default toolbar
              ),
            ),
          ),
        ),
      ],
    );
  }
}
