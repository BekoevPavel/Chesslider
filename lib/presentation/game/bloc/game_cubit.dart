import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_position_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/rooms_repository.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/score_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/figure_entity.dart';
import '../../../domain/enums/team_enum.dart';

class GameState {}

class InitialGame extends GameState {}

class LoadingGame extends GameState {}

class LoadedGame extends GameState {}

//---Cubit
class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  late StreamSubscription<StepEntity> lastStepStream;
  late BoardController _boardController;
  RoomRepository _roomRepository;
  final ScoreBloc _scoreBloc;

  List<StepEntity> steps = [];

  GameCubit(GameRepository gameRepository, ScoreBloc scoreBloc,
      RoomRepository roomRepository)
      : _gameRepository = gameRepository,
        _scoreBloc = scoreBloc,
        _roomRepository = roomRepository,
        super(InitialGame());

  Future<void> tapToStep(StepEntity step) async {
    AppLogger.tapToStep(step: step);

    foundFinalStep(step);

    _boardController.tapToStep(step);
    await _gameRepository.addStep(step);

    _scoreBloc.add(AddStepEvent(canMove: canMove()));

    // for (var figure in _boardController.whiteFigures) {
    //   showStep(figure);
    // }

    emit(LoadedGame());
  }

  bool canMove() {
    TeamEnum whoseMove = _boardController.refery.whoseMove;
    int countSteps = 0;
    if (whoseMove == TeamEnum.white) {
      for (FigureEntity figure in _boardController.whiteFigures) {
        countSteps = countSteps + checkActiveSteps(figure).length;
      }
    }
    if (whoseMove == TeamEnum.black) {
      for (FigureEntity figure in _boardController.blackFigures) {
        countSteps = countSteps + checkActiveSteps(figure).length;
      }
    }

    if (countSteps == 0) {
      return false;
    }

    return true;
  }

  List<StepEntity> checkActiveSteps(FigureEntity figure) {
    List<StepEntity> steps = [];
    if (!figure.reachedTheEnd) {
      final List<FigureEntity> finalLst = [
        ..._boardController.whiteFigures,
        ..._boardController.blackFigures
      ];

      var left = finalLst.where((element) {
        //print('----');
        //проверка слева
        bool lookToLeft = (element.x == figure.x - 1) || figure.x == 0;
        bool lookOnY = element.y == figure.y;
        if (lookToLeft && lookOnY) {
          return true;
        }
        return false;
      }).toList();
      var right = finalLst.where((element) {
        //print('----');
        //проверка слева
        bool lookToRight = (element.x == figure.x + 1) || figure.x == 7;
        bool lookOnY = element.y == figure.y;
        if (lookToRight && lookOnY) {
          return true;
        }
        return false;
      }).toList();

      var ahead_my = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight = (element.y == figure.y + 1) || figure.y == 7;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_x2_my = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight = (element.y == figure.y + 2) || figure.y == 7;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_other = finalLst.where((element) {
        bool lookToRight = (element.y == figure.y - 1) || figure.y == 0;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_x2_other = finalLst.where((element) {
        //print('----');
        //проверка слева

        bool lookToRight = (element.y == figure.y - 2) || figure.y == 0;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      // Столкновение фигур разных фигур.

      var conflicts = _calculateFiguresValue(figure);

      steps = [
        if (left.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          StepEntity(
            x: figure.x - 1,
            y: figure.y,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (right.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          StepEntity(
            x: figure.x + 1,
            y: figure.y,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_my.isEmpty && figure.id < 8)
          StepEntity(
            x: figure.x,
            y: figure.y + 1,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_x2_my.isEmpty &&
            figure.id < 8 &&
            ahead_my.isEmpty &&
            figure.countSteps == 0)
          StepEntity(
            x: figure.x,
            y: figure.y + 2,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        //-
        if (ahead_other.isEmpty && figure.id >= 8)
          StepEntity(
            x: figure.x,
            y: figure.y - 1,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
        if (ahead_x2_other.isEmpty &&
            figure.id >= 8 &&
            ahead_other.isEmpty &&
            figure.countSteps == 0)
          StepEntity(
            x: figure.x,
            y: figure.y - 2,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ),
      ];
      if (conflicts == 2) {
        var checkPositionAlFiguresLeft = finalLst.where((figure) {
          if (figure.x == figure.x - 1) {
            if (figure.y ==
                (figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2)) {
              return true;
            }
          }
          return false;
        }).toList();
        var checkPositionAlFiguresRight = finalLst.where((figure) {
          if (figure.x == figure.x + 1) {
            if (figure.y ==
                (figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2)) {
              return true;
            }
          }
          return false;
        }).toList();
        if (left.isEmpty && checkPositionAlFiguresLeft.isEmpty) {
          steps.add(StepEntity(
            x: figure.x - 1,
            y: figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ));
        }
        if (right.isEmpty && checkPositionAlFiguresRight.isEmpty) {
          steps.add(StepEntity(
            x: figure.x + 1,
            y: figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2,
            selectedFigure: figure,
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          ));
        }
      }

      if (conflicts == 1) {
        steps.add(StepEntity(
          x: figure.x,
          y: figure.team == TeamEnum.black ? figure.y - 1 : figure.y + 1,
          selectedFigure: figure,
          coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
          canKill: true,
        ));
      }
    }
    return steps;
  }

  Future<void> showStep(FigureEntity selectedEntity) async {
    AppLogger.selectedFigureLog(selectedEntity);

    if (!selectedEntity.reachedTheEnd) {
      final List<FigureEntity> finalLst = [
        ..._boardController.whiteFigures,
        ..._boardController.blackFigures
      ];

      emit(LoadingGame());
      emit(LoadedGame());

      //AppLogger.showAllFigure(finalLst);
      steps = checkActiveSteps(selectedEntity);
      if (_boardController.refery.whoseMove == selectedEntity.team) {
        _boardController.activateSteps(
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

      var foundedCoflict = _boardController.whiteFigures.where(
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
        for (var my in _boardController.blackFigures) {
          if (my.x == selectedFigure.x) {
            if (!my.reachedTheEnd) {
              myValue = myValue + my.value;
            }
          }
        }
        for (var other in _boardController.whiteFigures) {
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

      var foundedCoflict = _boardController.blackFigures.where(
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
        for (var my in _boardController.whiteFigures) {
          if (my.x == selectedFigure.x) {
            if (!my.reachedTheEnd) {
              myValue = myValue + my.value;
            }
          }
        }
        for (var other in _boardController.blackFigures) {
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

  Future<void> startGame(double boardWidth, TeamEnum myTeam) async {
    await AppDependencies().addBoardController(
        BoardController(boardWidth: boardWidth, myTeam: myTeam));
    _boardController = GetIt.instance.get<BoardController>();
    //_roomRepository.listenRoomState().listen((event) {});

    getLastStep();
    emit(LoadingGame());
    emit(LoadedGame());
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
    lastStepStream = _gameRepository.getLastStep().listen((event) {
      print('event: ${event.x} ${event.y}');
      FigureEntity? foundFigure;
      if (event.selectedFigure.id >= 8 &&
          _boardController.myTeam == TeamEnum.white) {
        print('black hod');
        foundFigure = _boardController.blackFigures
            .firstWhere((element) => element.id == event.selectedFigure.id);
        print('event id: ${event.selectedFigure.id}');
        print('succses');
        print(
            'foundedFigure:id  ${foundFigure.id} value: ${foundFigure.value}  team: ${foundFigure.team.name}');
        tapToStep(StepEntity(
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
            x: event.x,
            y: event.y,
            canKill: event.canKill,
            selectedFigure: foundFigure));
      } else if (event.selectedFigure.id < 8 &&
          _boardController.myTeam == TeamEnum.black) {
        print('white hod');
        foundFigure = _boardController.whiteFigures
            .firstWhere((element) => element.id == event.selectedFigure.id);
        tapToStep(StepEntity(
            coordinatiesEntity: CoordinatiesEntity(x: 0, y: 0),
            x: event.x,
            y: event.y,
            canKill: event.canKill,
            selectedFigure: foundFigure));
      }
    });
  }

  Future<void> disposeStream() async {
    lastStepStream.cancel();
  }
}
