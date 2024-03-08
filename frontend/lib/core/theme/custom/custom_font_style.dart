import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  /// Typography
  static const selectedLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.white,
    fontSize: 75,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const unSelectedLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 75,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 75,
    fontWeight: CustomFontWeight.regular,
  );

  static const textMedium = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 50,
    fontWeight: CustomFontWeight.regular,
  );

  static const textSmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 40,
    fontWeight: CustomFontWeight.regular,
  );

  static const textSmallEng = TextStyle(
    fontFamily: "PatrickHand",
    color: AppColors.black,
    fontSize: 30,
    fontWeight: CustomFontWeight.regular,
  );

}