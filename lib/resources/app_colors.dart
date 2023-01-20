import 'dart:ui';

import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';

class AppColors {
  AppColors._();

  static const Color blackFiguresBody = Color(0xff000000);
  static const Color whiteFiguresBody = Color(0xffffffff);
  static const Color blackFiguresBorder = Color(0xffffffff);
  static const Color whiteFiguresBorder = Color(0xff000000);

  static Color getFigureBody(TeamEnum team) =>
      team == TeamEnum.white ? whiteFiguresBody : blackFiguresBody;

  static Color getFigureBorder(TeamEnum team) =>
      team == TeamEnum.white ? whiteFiguresBorder : blackFiguresBorder;
}
