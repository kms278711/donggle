import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  static TextStyle getTextStyle(BuildContext context, TextStyle baseStyle) {
    double width = MediaQuery.of(context).size.width;

    // Define your scaling factor based on the device's width
    // For example, if the design is based on a 375 width screen
    double scaleFactor = width / 1480;

    return baseStyle.copyWith(fontSize: baseStyle.fontSize! * scaleFactor);
  }

  /// Typography
  static const titleMedium = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 80,
    fontWeight: CustomFontWeight.semiBold,
  );

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