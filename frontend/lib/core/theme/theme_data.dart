import 'package:flutter/material.dart';

import 'constant/app_colors.dart';


class CustomThemeData {
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    fontFamily: 'Nanumson_jangmi',
    tabBarTheme: TabBarTheme(
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: MaterialStatePropertyAll<Color>(
        Colors.grey[300] ?? Colors.grey,
      ),
    ),
  );
}
