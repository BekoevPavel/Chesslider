import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/refery.dart';
import 'package:flutter_chesslider_beta0/resources/base_game_variable.dart';

import '../../../domain/entities/figure_entity.dart';
import '../../../domain/entities/step_entity.dart';

class BoardController {
  double boardWidth;
  late double cell;
  double figureSize;
  late double step;
  bool multiplayer = true;
  TeamEnum myTeam = TeamEnum.white;

  Refery refery = Refery();

  List<FigureEntity> whiteFigures = [];
  List<FigureEntity> blackFigures = [];

  List<StepEntity> steps = [];

  void tapToStep(StepEntity step) {
    if (refery.whoseMove == TeamEnum.white) {
      refery.whoseMove = TeamEnum.black;
    } else {
      refery.whoseMove = TeamEnum.white;
    }

    step.selectedFigure.x = step.x;
    step.selectedFigure.y = step.y;
    step.selectedFigure.figureCoordinaties.x = _calculeCoordinate(step.x);
    step.selectedFigure.figureCoordinaties.y = _calculeCoordinate(step.y);
    step.selectedFigure.countSteps++;

    bool foundInMyFigures = whiteFigures
        .where((element) => element.id == step.selectedFigure.id)
        .isNotEmpty;
    if (step.canKill == true) {
      whiteFigures.removeWhere(
        (element) {
          if ((element.y == step.y && element.x == step.x) &&
              step.selectedFigure.team != element.team) {
            AppLogger.killFigure(step.selectedFigure, element);
            return true;
          }
          return false;
        },
      );
      blackFigures.removeWhere(
        (element) {
          if (element.y == step.y &&
              element.x == step.x &&
              step.selectedFigure.team != element.team) {
            AppLogger.killFigure(step.selectedFigure, element);
            return true;
          }
          return false;
        },
      );
    }

    whiteFigures.removeWhere((element) => element.id == step.selectedFigure.id);
    blackFigures.removeWhere((element) => element.id == step.selectedFigure.id);

    if (foundInMyFigures) {
      whiteFigures.add(step.selectedFigure);
    } else {
      blackFigures.add(step.selectedFigure);
    }
    steps.clear();
  }

  void activateSteps(List<StepEntity> newSteps, FigureEntity selectedEntity) {
    steps.clear();

    for (var newStep in newSteps) {
      newStep.coordinatiesEntity = CoordinatiesEntity(
          x: _calculeCoordinateStep(newStep.x),
          y: _calculeCoordinateStep(newStep.y));

      // steps.add(
      //   StepEntity(
      //       selectedFigure: selectedEntity,
      //       coordinatiesEntity: CoordinatiesEntity(
      //           x: _calculeCoordinateStep(newStep.x),
      //           y: _calculeCoordinateStep(newStep.y)),
      //       x: newStep.x,
      //       y: newStep.y),
      // );
    }
    steps = newSteps;
  }

  BoardController(
      {required this.boardWidth, this.figureSize = 24, required this.myTeam}) {
    cell = boardWidth / 8;
    step = (cell - figureSize) / 2;
    try {
      for (int i = 0; i < 8; i++) {
        var figure = FigureEntity(
            id: i,
            value: i + 1,
            weight: BaseGameVariables.figureWeight(i + 1),
            borderColor: Colors.black,
            color: Colors.white,
            figureCoordinaties: CoordinatiesEntity(
              x: _calculeCoordinate(i),
              y: _calculeCoordinate(0),
            ),
            figurePosition: CoordinatiesEntity(
              x: _calculeCoordinate(i),
              y: _calculeCoordinate(0),
            ),
            x: i,
            y: 0,
            team: TeamEnum.white);
        whiteFigures.add(figure);
      }
      // myFigures[2].y = 2;
      // myFigures[2].figureCoordinaties.y = _calculeCoordinate(myFigures[2].y);
      //
      // myFigures[3].x = myFigures[3].x - 1;
      // myFigures[3].figureCoordinaties.x = _calculeCoordinate(myFigures[3].x);

      for (int i = 0; i < 8; i++) {
        var figure = FigureEntity(
            id: i + 8,
            value: i + 1,
            weight: BaseGameVariables.figureWeight(i + 1),
            borderColor: Colors.white,
            color: Colors.black,
            figureCoordinaties: CoordinatiesEntity(
              x: _calculeCoordinate(i),
              y: _calculeCoordinate(7),
            ),
            figurePosition: CoordinatiesEntity(
              x: _calculeCoordinate(i),
              y: _calculeCoordinate(7),
            ),
            x: i,
            y: 7,
            team: TeamEnum.black);
        blackFigures.add(figure);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  double _calculeCoordinate(int pos) {
    return (cell * pos) ;
  }

  double _calculeCoordinateStep(int pos) {
    return (cell * pos);
  }

  void moveFigure(FigureEntity figureEntity, int x, int y) {
    figureEntity.x = x;
    figureEntity.y = y;
    figureEntity.figureCoordinaties.x = _calculeCoordinate(x);
    figureEntity.figureCoordinaties.y = _calculeCoordinate(y);
  }
}
