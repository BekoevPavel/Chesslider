import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';

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

  Map<String, dynamic> toFirebase() {
    // print('player1: ${players.map((e) => e.userID).toList()}');
    return {
      'x': x,
      'y': y,
      'figureID': selectedFigure.id,
      'canKill': canKill,
    };
  }

  factory StepEntity.fromFirebase(Map<String, dynamic> data) {
    final gotData = data['stepsPositions'][0];
    print('got data: ${gotData}');

    return StepEntity(
      coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
      x: gotData['x'],
      y: gotData['y'],
      canKill: gotData['canKill'],
      selectedFigure: FigureEntity(
          weight: 0,
          id: gotData['figureID'],
          value: 0,
          x: 0,
          y: 0,
          figureCoordinaties: CoordinatiesEntity(x: 0, y: 0),
          figurePosition: CoordinatiesEntity(x: 0, y: 0),
          color: Colors.red,
          borderColor: Colors.blue,
          team: TeamEnum.white),
    );
  }
}
