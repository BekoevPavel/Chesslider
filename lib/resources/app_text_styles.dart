//ignore_for_file: member-ordering
import 'package:flutter/material.dart';
import 'constants.dart';

abstract class AppTextStyles {
  // Headline

  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle headline1Bold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );

  static const TextStyle headline2Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle headline3Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  // Body 1

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  static const TextStyle body1Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  static const TextStyle body1Medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle body1Underline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    fontFamily: kFontFamily,
  );

  // Body 2

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  static const TextStyle body2Bold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  static const TextStyle body2Medium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle body2Underline = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    fontFamily: kFontFamily,
  );

  // Other

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle button2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.75,
    fontFamily: kFontFamily,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  static const TextStyle captionBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  static const TextStyle bodySmallBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: kFontFamily,
  );

  static const TextStyle bodySmallMedium = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
}
