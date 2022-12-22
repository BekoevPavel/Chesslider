import 'package:flutter_chesslider_beta0/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/entities/figure_position_entity.dart';

class StepEntity {
  int x;
  int y;
  CoordinatiesEntity coordinatiesEntity;
  StepEntity(
      {required this.coordinatiesEntity, required this.x, required this.y});
}
