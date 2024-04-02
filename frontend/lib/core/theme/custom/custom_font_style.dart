import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomFontStyle {
  static TextStyle getTextStyle(BuildContext context, TextStyle baseStyle) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = width / 1480;
    return baseStyle.copyWith(fontSize: baseStyle.fontSize! * scaleFactor);
  }

  /// Typography
  static const huge = TextStyle(
    fontFamily: "Itim",
    color: AppColors.white,
    fontSize: 400,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleMain = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 100,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleMainEng = TextStyle(
    fontFamily: "Itim",
    color: AppColors.black,
    fontSize: 100,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 180,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleMedium = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 80,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleMediumSmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 65,
    fontWeight: CustomFontWeight.semiBold,
  );


  static const titleSmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 50,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleSmallSmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 40,
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

  static const bodyMedium = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 50,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyMediumWhite = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.white,
    fontSize: 50,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodySmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 40,
    fontWeight: CustomFontWeight.regular,
  );

  static const textLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 80,
    fontWeight: CustomFontWeight.regular,
  );

  static const textMediumLarge2 = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 70,
    fontWeight: CustomFontWeight.regular,
  );

  static const textLargeEng = TextStyle(
    fontFamily: "PatrickHand",
    color: AppColors.black,
    fontSize: 70,
    fontWeight: CustomFontWeight.regular,
  );

  static const textMediumLarge = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 60,
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

  static const textMoreSmall = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.black,
    fontSize: 30,
    fontWeight: CustomFontWeight.regular,
  );

  static const textSmallEng = TextStyle(
    fontFamily: "PatrickHand",
    color: AppColors.black,
    fontSize: 30,
    fontWeight: CustomFontWeight.regular,
  );

  static const textSmallSmallEng = TextStyle(
    fontFamily: "PatrickHand",
    color: AppColors.black,
    fontSize: 20,
    fontWeight: CustomFontWeight.regular,
  );

  static const errorMedium = TextStyle(
    fontFamily: "Nanumson_jangmi",
    color: AppColors.error,
    fontSize: 50,
    fontWeight: CustomFontWeight.regular,
  );
}