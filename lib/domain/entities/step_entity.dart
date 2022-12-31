import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_position_entity.dart';

import 'figure_entity.dart';

class StepEntity {
  int x;
  int y;
  bool? canKill;
  CoordinatiesEntity coordinatiesEntity;
  FigureEntity selectedFigure;

  StepEntity(
      {required this.coordinatiesEntity,
      required this.x,
      required this.y,
      required this.selectedFigure,
      this.canKill});
}
