import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/entities/figure_entity.dart';
import 'package:flutter_chesslider_beta0/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/entities/step_entity.dart';

class BoardController {
  double boardWidth;
  late double cell;
  double figureSize;
  late double step;

  List<FigureEntity> myFigures = [];
  List<FigureEntity> otherFigures = [];

  List<StepEntity> steps = [];

  void activateSteps(List<PositionEntity> newSteps) {
    steps.clear();

    for (var newStep in newSteps) {
      steps.add(
        StepEntity(
            coordinatiesEntity: CoordinatiesEntity(
                x: _calculeCoordinateStep(newStep.x),
                y: _calculeCoordinateStep(newStep.y)),
            x: newStep.x,
            y: newStep.y),
      );
    }
  }

  BoardController({required this.boardWidth, this.figureSize = 24}) {
    cell = boardWidth / 8;
    step = (cell - figureSize) / 2;
    try {
      for (int i = 0; i < 8; i++) {
        var figure = FigureEntity(
          id: i,
          value: i + 1,
          borderColor: Colors.black,
          color: Colors.white,
          figureCoordinaties: CoordinatiesEntity(
            x: _calculeCoordinate(i),
            y: _calculeCoordinate(0),
          ),
          x: i,
          y: 0,
        );
        myFigures.add(figure);
      }
      myFigures[2].y = 2;
      myFigures[2].figureCoordinaties.y = _calculeCoordinate(myFigures[2].y);

      myFigures[3].x = myFigures[3].x - 1;
      myFigures[3].figureCoordinaties.x = _calculeCoordinate(myFigures[3].x);

      for (int i = 0; i < 8; i++) {
        var figure = FigureEntity(
          id: i + 8,
          value: i + 1,
          borderColor: Colors.white,
          color: Colors.black,
          figureCoordinaties: CoordinatiesEntity(
            x: _calculeCoordinate(i),
            y: _calculeCoordinate(7),
          ),
          x: i,
          y: 7,
        );
        otherFigures.add(figure);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  double _calculeCoordinate(int pos) {
    return (cell * pos + 1) + step;
  }

  double _calculeCoordinateStep(int pos) {
    return (cell * pos + 1);
  }

  void moveFigure(FigureEntity figureEntity, int x, int y) {
    figureEntity.x = x;
    figureEntity.y = y;
    figureEntity.figureCoordinaties.x = _calculeCoordinate(x);
    figureEntity.figureCoordinaties.y = _calculeCoordinate(y);
  }
}
