import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_decoration.dart';
import 'app_text_styles.dart';
import 'constants.dart';

//ignore_for_file: member-ordering
class AppTheme {
  AppTheme._();

  static final ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.orange,
    fontFamily: kFontFamily,
    brightness: Brightness.light,
    backgroundColor: AppColors.grayDimmed4,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    scrollbarTheme: ScrollbarThemeData(
      radius: const Radius.circular(4),
      thickness: MaterialStateProperty.resolveWith<double>((_) => 4),
      thumbColor: MaterialStateProperty.resolveWith<Color>(
          (_) => AppColors.grayDimmed2),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.grayDimmed4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
            borderRadius: AppDecoration.buttonBorder),
        primary: AppColors.highlight.withOpacity(0.3),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(0, Constants.buttonHeight),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.black),
        splashFactory: InkRipple.splashFactory,
        backgroundColor: Colors.transparent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grayDimmed3,
      border: AppDecoration.inputBorder,
      disabledBorder: AppDecoration.inputBorder,
      enabledBorder: AppDecoration.inputBorder,
      errorBorder: AppDecoration.inputBorder,
      focusedBorder: AppDecoration.inputBorder,
      focusedErrorBorder: AppDecoration.inputBorder,
      hintStyle: AppTextStyles.body1.copyWith(color: AppColors.gray),
      focusColor: AppColors.grayDimmed2,
      errorStyle: AppTextStyles.body1.copyWith(color: AppColors.red),
      contentPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 48),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
    ),
    scaffoldBackgroundColor: AppColors.grayDimmed4,
    disabledColor: AppColors.grayDimmed2,
    highlightColor: AppColors.highlight,
    timePickerTheme: const TimePickerThemeData(
      dayPeriodTextColor: AppColors.grayDimmed4,
      dayPeriodColor: AppColors.black,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.resolveWith((states) {
        return Colors.white;
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      side: const BorderSide(color: AppColors.grayDimmed1, width: 2),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.black;
        }

        return null;
      }),
    ),
    iconTheme: const IconThemeData(color: AppColors.grayDimmed2),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.grayDimmed4,
      unselectedLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.grayDimmed1,
      ),
      selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.black,
      ),
      selectedItemColor: AppColors.black,
    ),
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: AppColors.black),
      titleTextStyle: AppTextStyles.headline3.copyWith(
        color: AppColors.black,
      ),
      backgroundColor: AppColors.grayDimmed4,
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: AppTextStyles.headline3.copyWith(color: AppColors.black),
      contentTextStyle: AppTextStyles.body2.copyWith(color: AppColors.gray),
    ),
    shadowColor: AppColors.shadow,
    splashColor: AppColors.highlight.withOpacity(0.5),
  );

  //ThemeData

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.orange,
    fontFamily: kFontFamily,
    brightness: Brightness.dark,
    backgroundColor: AppColors.blackDimmed2,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.blackDimmed1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
            borderRadius: AppDecoration.buttonBorder),
        primary: AppColors.darkHighlight.withOpacity(0.3),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      radius: const Radius.circular(4),
      thickness: MaterialStateProperty.resolveWith<double>((_) => 4),
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((_) => AppColors.gray),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.blackDimmed2,
      border: AppDecoration.inputBorder,
      disabledBorder: AppDecoration.inputBorder,
      enabledBorder: AppDecoration.inputBorder,
      errorBorder: AppDecoration.inputBorder,
      focusedBorder: AppDecoration.inputBorder,
      focusedErrorBorder: AppDecoration.inputBorder,
      hintStyle: AppTextStyles.body1.copyWith(color: AppColors.grayDimmed1),
      focusColor: AppColors.gray,
      errorStyle: AppTextStyles.body1.copyWith(color: AppColors.red),
      contentPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 48),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.black,
    disabledColor: AppColors.gray,
    highlightColor: AppColors.darkHighlight,
    timePickerTheme: const TimePickerThemeData(
      dayPeriodTextColor: AppColors.blackDimmed1,
      dayPeriodColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.resolveWith((states) {
        return AppColors.black;
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      side: const BorderSide(color: AppColors.gray, width: 2),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }

        return null;
      }),
    ),
    iconTheme: const IconThemeData(color: AppColors.grayDimmed1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      unselectedLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.grayDimmed1,
      ),
      selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
        color: AppColors.grayDimmed4,
      ),
      selectedItemColor: AppColors.grayDimmed4,
    ),
    cardColor: AppColors.blackDimmed2,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: AppTextStyles.headline3.copyWith(
        color: Colors.white,
      ),
      backgroundColor: AppColors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppTextStyles.button.copyWith(color: Colors.white),
        splashFactory: InkRipple.splashFactory,
        backgroundColor: Colors.transparent,
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: AppTextStyles.headline3.copyWith(color: Colors.white),
      contentTextStyle:
          AppTextStyles.body2.copyWith(color: AppColors.grayDimmed1),
    ),
    splashColor: AppColors.darkHighlight.withOpacity(0.5),
    shadowColor: Colors.transparent,
  );

  static SystemUiOverlayStyle systemUiOverlayStyleLight =
      SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.transparent.withOpacity(0.001),
    statusBarBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent.withOpacity(0.001),
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle systemUiOverlayStyleDark =
      SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: Colors.transparent.withOpacity(0.001),
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent.withOpacity(0.001),
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
