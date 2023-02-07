import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/resources/extentions/build_context_extension.dart';
export 'constants.dart';
export 'app_colors.dart';
export 'app_decoration.dart';
export 'app_theme.dart';

//ignore_for_file: member-ordering
class AppDecoration {
  AppDecoration._();

  static const BorderRadiusGeometry buttonBorder =
      BorderRadius.all(Radius.circular(8));
  static const BorderRadius bottomSheetBorder = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  );

  static BorderRadius cardBorder(double? radius) =>
      BorderRadius.all(Radius.circular(radius ?? 12));
  static const BorderRadiusGeometry dialogBorder =
      BorderRadius.all(Radius.circular(16));
  static const InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  );

  static const InputBorder searchBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(100)),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  );

  static const InputBorder numberBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: Colors.green, width: 1.0),
  );

  static BoxShadow coloredShadow(Color color) => BoxShadow(
        color: color.withOpacity(0.2),
        offset: const Offset(0.7, 1.1),
        blurStyle: BlurStyle.inner,
      );

  static BoxShadow cardShadow(BuildContext context) => BoxShadow(
        color: context.theme.shadowColor.withOpacity(0.1),
        offset: const Offset(0, 3),
        blurRadius: 3,
      );
}
