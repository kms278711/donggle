import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class CircleBackIcon extends StatelessWidget {
  final double? size;

  const CircleBackIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    double _size = size ?? MediaQuery.of(context).size.width * 0.05;

    return Image.asset(
      AppIcons.circle_back,
      width: _size,
      height: _size,
    );
  }
}
