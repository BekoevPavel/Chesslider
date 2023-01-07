import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';

import '../../../domain/entities/figure_entity.dart';
import '../../../domain/enums/team_enum.dart';

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
  final GameRepository _gameRepository;
  late Stream<StepEntity> lastStepStream;

  List<StepEntity> steps = [];

  GameCubit(GameRepository gameRepository)
      : _gameRepository = gameRepository,
        super(InitialGame());

  Future<void> tapToStep(StepEntity step) async {
    AppLogger.tapToStep(step: step);

    foundFinalStep(step);

    boardController.tapToStep(step);
    await _gameRepository.addStep(step);

    emit(LoadedGame(boardController: boardController));
  }

  Future<void> showStep(FigureEntity selectedEntity) async {
    AppLogger.selectedFigureLog(selectedEntity);

    if (!selectedEntity.reachedTheEnd) {
      final List<FigureEntity> finalLst = [
        ...boardController.whiteFigures,
        ...boardController.blackFigures
      ];

      emit(LoadingGame());
      emit(LoadedGame(boardController: boardController));

      //AppLogger.showAllFigure(finalLst);

      var left = finalLst.where((element) {
        //print('----');
        //проверка слева
        bool lookToLeft =
            (element.x == selectedEntity.x - 1) || selectedEntity.x == 0;
        bool lookOnY = element.y == selectedEntity.y;
        if (lookToLeft && lookOnY) {
          return true;
        }
        return false;
      }).toList();
      var right = finalLst.where((element) {
        //print('----');
        //проверка слева
        bool lookToRight =
            (element.x == selectedEntity.x + 1) || selectedEntity.x == 7;
        bool lookOnY = element.y == selectedEntity.y;
        if (lookToRight && lookOnY) {
          return true;
        }
        return false;
      }).toList();

      var ahead_my = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight =
            (element.y == selectedEntity.y + 1) || selectedEntity.y == 7;
        bool lookOnY = element.x == selectedEntity.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_x2_my = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight =
            (element.y == selectedEntity.y + 2) || selectedEntity.y == 7;
        bool lookOnY = element.x == selectedEntity.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_other = finalLst.where((element) {
        bool lookToRight =
            (element.y == selectedEntity.y - 1) || selectedEntity.y == 0;
        bool lookOnY = element.x == selectedEntity.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_x2_other = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight =
            (element.y == selectedEntity.y - 2) || selectedEntity.y == 0;
        bool lookOnY = element.x == selectedEntity.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      // Столкновение фигур разных фигур.

      var conflicts = _calculateFiguresValue(selectedEntity);

      steps = [
        if (left.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          StepEntity(
            x: selectedEntity.x - 1,
            y: selectedEntity.y,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (right.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          StepEntity(
            x: selectedEntity.x + 1,
            y: selectedEntity.y,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_my.isEmpty && selectedEntity.id < 8)
          StepEntity(
            x: selectedEntity.x,
            y: selectedEntity.y + 1,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_x2_my.isEmpty &&
            selectedEntity.id < 8 &&
            ahead_my.isEmpty &&
            selectedEntity.countSteps == 0)
          StepEntity(
            x: selectedEntity.x,
            y: selectedEntity.y + 2,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        //-
        if (ahead_other.isEmpty && selectedEntity.id >= 8)
          StepEntity(
            x: selectedEntity.x,
            y: selectedEntity.y - 1,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_x2_other.isEmpty &&
            selectedEntity.id >= 8 &&
            ahead_other.isEmpty &&
            selectedEntity.countSteps == 0)
          StepEntity(
            x: selectedEntity.x,
            y: selectedEntity.y - 2,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
      ];
      if (conflicts == 2) {
        var checkPositionAlFiguresLeft = finalLst.where((figure) {
          if (figure.x == selectedEntity.x - 1) {
            if (figure.y ==
                (selectedEntity.team == TeamEnum.black
                    ? selectedEntity.y + 2
                    : selectedEntity.y - 2)) {
              return true;
            }
          }
          return false;
        }).toList();
        var checkPositionAlFiguresRight = finalLst.where((figure) {
          if (figure.x == selectedEntity.x + 1) {
            if (figure.y ==
                (selectedEntity.team == TeamEnum.black
                    ? selectedEntity.y + 2
                    : selectedEntity.y - 2)) {
              return true;
            }
          }
          return false;
        }).toList();
        if (left.isEmpty && checkPositionAlFiguresLeft.isEmpty) {
          steps.add(StepEntity(
            x: selectedEntity.x - 1,
            y: selectedEntity.team == TeamEnum.black
                ? selectedEntity.y + 2
                : selectedEntity.y - 2,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ));
        }
        if (right.isEmpty && checkPositionAlFiguresRight.isEmpty) {
          steps.add(StepEntity(
            x: selectedEntity.x + 1,
            y: selectedEntity.team == TeamEnum.black
                ? selectedEntity.y + 2
                : selectedEntity.y - 2,
            selectedFigure: selectedEntity,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ));
        }
      }

      if (conflicts == 1) {
        steps.add(StepEntity(
          x: selectedEntity.x,
          y: selectedEntity.team == TeamEnum.black
              ? selectedEntity.y - 1
              : selectedEntity.y + 1,
          selectedFigure: selectedEntity,
          coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          canKill: true,
        ));
      }
      if (boardController.refery.whoseMove == selectedEntity.team) {
        boardController.activateSteps(
          steps,
          selectedEntity,
        );
      }
    }
  }

  /// 0 eсли равны, 1 если myValue>OtherValue, 2 если myValue>OtherValue,
  int _calculateFiguresValue(
    FigureEntity selectedFigure,
  ) {
    if (selectedFigure.team == TeamEnum.black) {
      int rowX = selectedFigure.x;

      var foundedCoflict = boardController.whiteFigures.where(
        (element) {
          if (element.x == rowX) {
            if (element.y == selectedFigure.y - 1) {
              return true;
            }
          }
          return false;
        },
      ).toList();
      if (foundedCoflict.isNotEmpty) {
        int myValue = 0;
        int otherValue = 0;
        for (var my in boardController.blackFigures) {
          if (my.x == selectedFigure.x) {
            if (!my.reachedTheEnd) {
              myValue = myValue + my.value;
            }
          }
        }
        for (var other in boardController.whiteFigures) {
          if (other.x == selectedFigure.x) {
            if (!other.reachedTheEnd) {
              otherValue = otherValue + other.value;
            }
          }
        }

        if (myValue > otherValue) {
          return 1;
        } else if (otherValue > myValue) {
          return 2;
        } else if (myValue == otherValue) {
          return 0;
        }

        AppLogger.figuresConflict(
            selectedFigure, foundedCoflict.first, myValue, otherValue);
      }
    }
    if (selectedFigure.team == TeamEnum.white) {
      int rowX = selectedFigure.x;

      var foundedCoflict = boardController.blackFigures.where(
        (element) {
          if (element.x == rowX) {
            if (element.y == selectedFigure.y + 1) {
              return true;
            }
          }
          return false;
        },
      ).toList();
      if (foundedCoflict.isNotEmpty) {
        int myValue = 0;
        int otherValue = 0;
        for (var my in boardController.whiteFigures) {
          if (my.x == selectedFigure.x) {
            if (!my.reachedTheEnd) {
              myValue = myValue + my.value;
            }
          }
        }
        for (var other in boardController.blackFigures) {
          if (other.x == selectedFigure.x) {
            if (!other.reachedTheEnd) {
              otherValue = otherValue + other.value;
            }
          }
        }
        if (myValue > otherValue) {
          return 1;
        } else if (otherValue > myValue) {
          return 2;
        } else if (myValue == otherValue) {
          return 0;
        }
        AppLogger.figuresConflict(
            selectedFigure, foundedCoflict.first, myValue, otherValue);
      }
    }
    return -1;
  }

  Future<void> startGame(double boardWidth) async {
    boardController = BoardController(boardWidth: boardWidth);
    getLastStep();
    emit(LoadingGame());
    emit(LoadedGame(boardController: boardController));
  }

  Future<void> foundFinalStep(StepEntity step) async {
    if (step.selectedFigure.team == TeamEnum.black && step.y == 0) {
      AppLogger.figureReachedTheEnd(step.selectedFigure);
      step.selectedFigure.reachedTheEnd = true;
    }
    if (step.selectedFigure.team == TeamEnum.white && step.y == 7) {
      AppLogger.figureReachedTheEnd(step.selectedFigure);
      step.selectedFigure.reachedTheEnd = true;
    }
  }



  Future<void> getLastStep() async {
    lastStepStream = _gameRepository.getLastStep();

    lastStepStream.listen((event) {
      print('event: ${event.x} ${event.y}');
      FigureEntity? foundFigure;
      if (event.selectedFigure.id >= 8 &&
          boardController.myTeam == TeamEnum.white) {
        print('black hod');
        foundFigure = boardController.blackFigures
            .firstWhere((element) => element.id == event.selectedFigure.id);
        tapToStep(StepEntity(
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
            x: event.x,
            y: event.y,
            selectedFigure: foundFigure));
      } else if (event.selectedFigure.id < 8 &&
          boardController.myTeam == TeamEnum.black) {
        print('white hod');
        foundFigure = boardController.whiteFigures
            .firstWhere((element) => element.id == event.selectedFigure.id);
        tapToStep(StepEntity(
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
            x: event.x,
            y: event.y,
            selectedFigure: foundFigure));
      }
    });
  }
}
