import 'package:flutter/material.dart';

import 'figure_coordinates_entity.dart';
import 'figure_position_entity.dart';

class FigureEntity {
  int id;
  int value;
  int x;
  int y;
  //PositionEntity figurePosition;
  CoordinatiesEntity figureCoordinaties;
  Color color;
  Color borderColor;

  FigureEntity(
      {required this.id,
      required this.value,
      required this.x,
      required this.y,
      required this.figureCoordinaties,
      // required this.figurePosition,
      required this.color,
      required this.borderColor});
}
