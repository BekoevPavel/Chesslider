import 'dart:ui';

import 'package:flutter/material.dart';
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

  static const Color green = Color(0xff00A241);

  static const Color orange = Color(0xffF47D32);

  static const Color orangeDimmed = Color(0xffFFC39E);

  static const Color yellow = Color(0xffF9C50D);

  static const Color lightOrange = Color(0xfff7bd97);
  static const Color red = Color(0xffE34949);
  static const Color grey = Color(0xffC4CBD1);
  static const Color mainBlack = Color(0xff172126);
  static const Color iconColor = Color(0xff90979C);

  /// black

  static const Color black = Color(0xff161B1F);
  static const Color blackDimmed2 = Color(0xff262C30);
  static const Color blackDimmed1 = Color(0xff1B2124);
  static const Color darkBarrier = Color(0xff0D1113);
  static const Color barrier = Color(0xff161B1F);

  /// gray

  static const Color gray = Color(0xff586066);
  static const Color grayDimmed1 = Color(0xff90979C);
  static const Color grayDimmed2 = Color(0xffC4CBD1);
  static const Color grayDimmed3 = Color(0xffE9ECEF);
  static const Color grayDimmed4 = Color(0xffFBFCFD);
  static const Color highlight = Color(0xffebeff2);
  static const Color darkHighlight = Color(0xff2b3034);
  static const Color darkBaseHighlight = Color(0xff1a1f23);
  static const Color lightBlue = Color(0xffE3EAF0);

  /// dark
  /// shimmer
  static const Color lightShimmer = Color(0xffEBEFF2);
  static const Color silver = Color(0xff86989C);
  static const Color gold = Color(0xffAE8D27);
  static const Color ruby = Color(0xffE56064);
  static const Color shadow = Color(0xff467795);
  static const Color lightPurple = Color(0xffCBCEF4);
  static const Color darkBlue = Color(0xff002A3A);
}
