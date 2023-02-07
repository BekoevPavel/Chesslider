import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/refery.dart';
import 'package:flutter_chesslider_beta0/resources/base_game_variable.dart';

import '../../../data/dto/coordinates/coordinates.dart';
import '../../../data/dto/figure/figure.dart';
import '../../../data/dto/step/step.dart' as s;

class BoardController {
  double boardWidth;
  late double cell;
  double figureSize;
  late double step;
  bool multiplayer = true;
  TeamEnum myTeam = TeamEnum.white;

  Refery refery = Refery();

  List<Figure> whiteFigures = [];
  List<Figure> blackFigures = [];

  List<s.Step> steps = [];

  void tapToStep(s.Step step) {
    //TODO: РАзрбочить для оффлайн игры
    // if (refery.whoseMove == TeamEnum.white) {
    //   refery.whoseMove = TeamEnum.black;
    // } else {
    //   refery.whoseMove = TeamEnum.white;
    // }

    step.figure.x = step.x;
    step.figure.y = step.y;
    step.figure.coordinates.x = _calculeCoordinate(step.x);
    step.figure.coordinates.y = _calculeCoordinate(step.y);
    step.figure.countSteps++;

    bool foundInMyFigures = whiteFigures
        .where((element) => element.id == step.figure.id)
        .isNotEmpty;
    if (step.canKill == true) {
      whiteFigures.removeWhere(
        (element) {
          if ((element.y == step.y && element.x == step.x) &&
              step.figure.team != element.team) {
            AppLogger.killFigure(step.figure, element);
            return true;
          }
          return false;
        },
      );
      blackFigures.removeWhere(
        (element) {
          if (element.y == step.y &&
              element.x == step.x &&
              step.figure.team != element.team) {
            AppLogger.killFigure(step.figure, element);
            return true;
          }
          return false;
        },
      );
    }

    whiteFigures.removeWhere((element) => element.id == step.figure.id);
    blackFigures.removeWhere((element) => element.id == step.figure.id);

    if (foundInMyFigures) {
      whiteFigures.add(step.figure);
    } else {
      blackFigures.add(step.figure);
    }
    steps.clear();
  }

  void activateSteps(List<s.Step> newSteps, Figure selectedEntity) {
    steps.clear();

    for (var newStep in newSteps) {
      newStep.coordinates = Coordinates(
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
        var figure = Figure(
            id: i,
            value: i + 1,
            points: BaseGameVariables.figureWeight(i + 1),
            coordinates: Coordinates(
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
        var figure = Figure(
            id: i + 8,
            value: i + 1,
            points: BaseGameVariables.figureWeight(i + 1),
            coordinates: Coordinates(
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
    return (cell * pos);
  }

  double _calculeCoordinateStep(int pos) {
    return (cell * pos);
  }

  void moveFigure(Figure figureEntity, int x, int y) {
    figureEntity.x = x;
    figureEntity.y = y;
    figureEntity.coordinates.x = _calculeCoordinate(x);
    figureEntity.coordinates.y = _calculeCoordinate(y);
  }
}
