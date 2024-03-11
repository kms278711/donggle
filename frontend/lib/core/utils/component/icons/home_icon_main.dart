import 'package:flutter/material.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';

class HomeIconMain extends StatelessWidget {
  final double? size;

  const HomeIconMain({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    double _size = size ?? MediaQuery.of(context).size.width * 0.05;

    return Image.asset(
      AppIcons.home_icon,
      width: _size,
      height: _size,
    );
  }
}
