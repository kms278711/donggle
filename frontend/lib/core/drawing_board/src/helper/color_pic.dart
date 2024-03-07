import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPic extends StatelessWidget {
  const ColorPic({super.key, this.nowColor});

  final Color? nowColor;

  @override
  Widget build(BuildContext context) {
    Color? pickColor = nowColor;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
            child: AlertDialog(
              title: const Text('색깔을 골라보세요!', style: TextStyle(fontSize: 30),),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: pickColor ?? Colors.red,
                  onColorChanged: (Color c) => pickColor = c,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text(
                      '확인',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    onPressed: () => Navigator.pop(context, pickColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
