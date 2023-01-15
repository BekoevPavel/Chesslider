import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';

import 'figure_coordinates_entity.dart';

class FigureEntity {
  int id;
  int value;
  int x;
  int y;
  TeamEnum team;
  CoordinatiesEntity figureCoordinaties;
  CoordinatiesEntity figurePosition;
  int countSteps = 0;
  Color color;
  Color borderColor;
  bool reachedTheEnd = false;
  int weight;

  FigureEntity({
    required this.id,
    required this.value,
    required this.x,
    required this.y,
    required this.figureCoordinaties,
    required this.figurePosition,
    required this.color,
    required this.borderColor,
    required this.team,
    required this.weight,
  });
}
