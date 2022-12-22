import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/entities/figure_entity.dart';
import 'package:flutter_chesslider_beta0/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/states/board_state.dart';
import 'package:flutter_chesslider_beta0/widgets/step_widget.dart';

class GameState {}

class InitialGame extends GameState {}

class LoadingGame extends GameState {}

class LoadedGame extends GameState {
  BoardController boardController;
  LoadedGame({required this.boardController});
}

//---Cubit
class GameCubit extends Cubit<GameState> {
  late BoardController boardController;
  GameCubit() : super(InitialGame());
  Future<void> showStep(FigureEntity figureEntity) async {
    final List<FigureEntity> finallst = [
      ...boardController.myFigures,
      ...boardController.otherFigures
    ];

    boardController.activateSteps([
      PositionEntity(x: 2, y: 4),
      PositionEntity(x: 3, y: 4),
      PositionEntity(x: 3, y: 5),
    ]);

    emit(LoadingGame());
    emit(LoadedGame(boardController: boardController));
    print('id: ${figureEntity.id}');
    var left = finallst.where((element) {
      //print('----');
      //проверка слева
      bool lookToLeft =
          (element.x == figureEntity.x - 1) || figureEntity.x == 0;
      bool lookOnY = element.y == figureEntity.y;
      if (lookToLeft && lookOnY) {
        return true;
      }
      return false;
    }).toList();
    var right = finallst.where((element) {
      //print('----');
      //проверка слева
      bool lookToRight =
          (element.x == figureEntity.x + 1) || figureEntity.x == 7;
      bool lookOnY = element.y == figureEntity.y;
      if (lookToRight && lookOnY) {
        return true;
      }
      return false;
    }).toList();

    var ahead_my = finallst.where((element) {
      //print('----');
      //проверка слева

      bool lookToRight =
          (element.y == figureEntity.y + 1) || figureEntity.y == 7;
      bool lookOnY = element.x == figureEntity.x;
      if (lookToRight && lookOnY) {
        return true;
      }

      return false;
    }).toList();

    var ahead_x2_my = finallst.where((element) {
      //print('----');
      //проверка слева

      bool lookToRight =
          (element.y == figureEntity.y + 2) || figureEntity.y == 7;
      bool lookOnY = element.x == figureEntity.x;
      if (lookToRight && lookOnY) {
        return true;
      }

      return false;
    }).toList();

    var ahead_other = finallst.where((element) {
      bool lookToRight =
          (element.y == figureEntity.y - 1) || figureEntity.y == 0;
      bool lookOnY = element.x == figureEntity.x;
      if (lookToRight && lookOnY) {
        return true;
      }

      return false;
    }).toList();

    var ahead_x2_other = finallst.where((element) {
      //print('----');
      //проверка слева

      bool lookToRight =
          (element.y == figureEntity.y - 2) || figureEntity.y == 0;
      bool lookOnY = element.x == figureEntity.x;
      if (lookToRight && lookOnY) {
        return true;
      }

      return false;
    }).toList();

    boardController.activateSteps([
      if (left.isEmpty)
        PositionEntity(x: figureEntity.x - 1, y: figureEntity.y),
      if (right.isEmpty)
        PositionEntity(x: figureEntity.x + 1, y: figureEntity.y),
      if (ahead_my.isEmpty && figureEntity.id < 8)
        PositionEntity(x: figureEntity.x, y: figureEntity.y + 1),
      if (ahead_x2_my.isEmpty && figureEntity.id < 8 && ahead_my.isEmpty)
        PositionEntity(x: figureEntity.x, y: figureEntity.y + 2),
      //-
      if (ahead_other.isEmpty && figureEntity.id >= 8)
        PositionEntity(x: figureEntity.x, y: figureEntity.y - 1),
      if (ahead_x2_other.isEmpty && figureEntity.id >= 8 && ahead_other.isEmpty)
        PositionEntity(x: figureEntity.x, y: figureEntity.y - 2),
    ]);

    // for (var i in result) {
    //   print('findIDs: ${i.id}');
    // }
    // print('result: $result');
  }

  Future<void> startGame(double boardWidth) async {
    boardController = BoardController(boardWidth: boardWidth);
    emit(LoadingGame());
    emit(LoadedGame(boardController: boardController));
  }
}
