import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  /// Typography
  static const selectedLarge = TextStyle(
    color: AppColors.white,
    fontSize: 75,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const unSelectedLarge = TextStyle(
    color: AppColors.black,
    fontSize: 75,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyLarge = TextStyle(
    color: AppColors.black,
    fontSize: 75,
    fontWeight: CustomFontWeight.regular,
  );

}