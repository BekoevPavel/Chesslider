import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/rooms_repository.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/score_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:get_it/get_it.dart';
import '../../../data/dto/coordinates/coordinates.dart';
import '../../../data/dto/figure/figure.dart';
import '../../../data/dto/player/player.dart';
import '../../../data/dto/step/step.dart' as s;

import '../../../domain/enums/team_enum.dart';
import '../../home/bloc/home_bloc.dart';

class GameState extends BaseState {
  GameState({super.status = BaseStatus.initial, this.enemyPlayer, this.isExit});

  Player? enemyPlayer;
  bool? isExit;

  @override
  GameState copyWith(
      {required BaseStatus status, Player? enemyPlayer, bool? isExit}) {
    return GameState(
        status: status,
        enemyPlayer: enemyPlayer ?? this.enemyPlayer,
        isExit: isExit ?? this.isExit);
  }
}

//---Cubit
class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  late StreamSubscription<s.Step> lastStepStream;
  late StreamSubscription<Player?> listenOtherPlayerStream;
  late BoardController _boardController;
  RoomRepository _roomRepository;
  final ScoreBloc _scoreBloc;

  List<s.Step> steps = [];
  HomeBloc homeBloc;

  GameCubit(GameRepository gameRepository, RoomRepository roomRepository,
      ScoreBloc scoreBloc, this.homeBloc)
      : _gameRepository = gameRepository,
        _roomRepository = roomRepository,
        _scoreBloc = scoreBloc,
        super(GameState());

  Future<void> tapToStep(s.Step step, [bool isEnemyStep = false]) async {
    AppLogger.tapToStep(step: step);

    foundFinalStep(step);
    // emit(state.copyWith(status: BaseStatus.loading));

    _boardController.refery.whoseMove =
        _boardController.myTeam == TeamEnum.white
            ? TeamEnum.black
            : TeamEnum.white;
    _boardController.tapToStep(step);
    //TODO: ???????????????? ???????? ???? ??????????????????
    if (isEnemyStep == false) {
      await _gameRepository.addStep(step);
    }

    _scoreBloc.add(AddStepEvent(canMove: canMove()));

    // for (var figure in _boardController.whiteFigures) {
    //   showStep(figure);
    // }

    emit(state.copyWith(status: BaseStatus.success));
  }

  bool canMove() {
    TeamEnum whoseMove = _boardController.refery.whoseMove;
    int countSteps = 0;
    if (whoseMove == TeamEnum.white) {
      for (Figure figure in _boardController.whiteFigures) {
        countSteps = countSteps + checkActiveSteps(figure).length;
      }
    }
    if (whoseMove == TeamEnum.black) {
      for (Figure figure in _boardController.blackFigures) {
        countSteps = countSteps + checkActiveSteps(figure).length;
      }
    }

    if (countSteps == 0) {
      return false;
    }

    return true;
  }

  List<s.Step> checkActiveSteps(Figure figure) {
    List<s.Step> steps = [];
    if (!figure.reachedTheEnd) {
      final List<Figure> finalLst = [
        ..._boardController.whiteFigures,
        ..._boardController.blackFigures
      ];

      var left = finalLst.where((element) {
        //print('----');
        //???????????????? ??????????
        bool lookToLeft = (element.x == figure.x - 1) || figure.x == 0;
        bool lookOnY = element.y == figure.y;
        if (lookToLeft && lookOnY) {
          return true;
        }
        return false;
      }).toList();
      var right = finalLst.where((element) {
        //print('----');
        //???????????????? ??????????
        bool lookToRight = (element.x == figure.x + 1) || figure.x == 7;
        bool lookOnY = element.y == figure.y;
        if (lookToRight && lookOnY) {
          return true;
        }
        return false;
      }).toList();

      var ahead_my = finalLst.where((element) {
        //print('----');
        //???????????????? ??????????

        bool lookToRight = (element.y == figure.y + 1) || figure.y == 7;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      var ahead_x2_my = finalLst.where((element) {
        //print('----');
        //???????????????? ??????????

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
        //???????????????? ??????????

        bool lookToRight = (element.y == figure.y - 2) || figure.y == 0;
        bool lookOnY = element.x == figure.x;
        if (lookToRight && lookOnY) {
          return true;
        }

        return false;
      }).toList();

      // ???????????????????????? ?????????? ???????????? ??????????.

      var conflicts = _calculateFiguresValue(figure);

      steps = [
        if (left.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          s.Step(
            x: figure.x - 1,
            y: figure.y,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ),
        if (right.isEmpty &&
            (conflicts == -1 || conflicts == 1) &&
            conflicts != 0)
          s.Step(
            x: figure.x + 1,
            y: figure.y,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ),
        if (ahead_my.isEmpty && figure.id < 8)
          s.Step(
            x: figure.x,
            y: figure.y + 1,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ),
        if (ahead_x2_my.isEmpty &&
            figure.id < 8 &&
            ahead_my.isEmpty &&
            figure.countSteps == 0)
          s.Step(
            x: figure.x,
            y: figure.y + 2,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ),
        //-
        if (ahead_other.isEmpty && figure.id >= 8)
          s.Step(
            x: figure.x,
            y: figure.y - 1,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ),
        if (ahead_x2_other.isEmpty &&
            figure.id >= 8 &&
            ahead_other.isEmpty &&
            figure.countSteps == 0)
          s.Step(
            x: figure.x,
            y: figure.y - 2,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
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
          steps.add(s.Step(
            x: figure.x - 1,
            y: figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ));
        }
        if (right.isEmpty && checkPositionAlFiguresRight.isEmpty) {
          steps.add(s.Step(
            x: figure.x + 1,
            y: figure.team == TeamEnum.black ? figure.y + 2 : figure.y - 2,
            figure: figure,
            coordinates: Coordinates(x: 0, y: 0),
          ));
        }
      }

      if (conflicts == 1) {
        steps.add(s.Step(
          x: figure.x,
          y: figure.team == TeamEnum.black ? figure.y - 1 : figure.y + 1,
          figure: figure,
          coordinates: Coordinates(x: 0, y: 0),
          canKill: true,
        ));
      }
    }
    return steps;
  }

  Future<void> showStep(Figure selectedEntity) async {
    AppLogger.selectedFigureLog(selectedEntity);

    if (!selectedEntity.reachedTheEnd) {
      final List<Figure> finalLst = [
        ..._boardController.whiteFigures,
        ..._boardController.blackFigures
      ];

      //AppLogger.showAllFigure(finalLst);
      steps = checkActiveSteps(selectedEntity);
      if (_boardController.refery.whoseMove == selectedEntity.team) {
        _boardController.activateSteps(
          steps,
          selectedEntity,
        );
      }
      //emit(state.copyWith(status: BaseStatus.loading));
      emit(state.copyWith(status: BaseStatus.success));
    }
  }

  /// 0 e?????? ??????????, 1 ???????? myValue>OtherValue, 2 ???????? myValue>OtherValue,
  int _calculateFiguresValue(
    Figure selectedFigure,
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

    // emit(LoadingGame());
    // emit(LoadedGame());
    emit(state.copyWith(status: BaseStatus.loading));
    emit(state.copyWith(status: BaseStatus.success));
    getLastStep();

    listenOtherPlayerStream =
        _roomRepository.listenOtherPlayerState().listen((player) async {
      // print('eventMY: ${event.}');
      if (player != null) {
        AppLogger.sendI(
            '?????????????????????? ??????????: ${player.username} , id: ${player.userID} rating: ${player.rating}');

        //print('PlayerRating: ${player.rating} , ${player.username}');
        await AppDependencies().setEnemyPlayer(player);
        emit(state.copyWith(status: BaseStatus.success, enemyPlayer: player));
      }
      if (player == null) {
        disposeStream();
        if (homeBloc.wasExit == false) {
          emit(
            state.copyWith(status: BaseStatus.success, isExit: true),
          );
        }
      }
    });
  }

  Future<void> foundFinalStep(s.Step step) async {
    if (step.figure.team == TeamEnum.black && step.y == 0) {
      AppLogger.figureReachedTheEnd(step.figure);
      step.figure.reachedTheEnd = true;
    }
    if (step.figure.team == TeamEnum.white && step.y == 7) {
      AppLogger.figureReachedTheEnd(step.figure);
      step.figure.reachedTheEnd = true;
    }
  }

  void getLastStep() {
    lastStepStream = _gameRepository.getLastStep().listen(
      (event) {
        Figure? foundFigure;

        if (event.figure.team == TeamEnum.black &&
            _boardController.myTeam == TeamEnum.white &&
            _boardController.refery.whoseMove == event.figure.team) {
          print('black hod');

          foundFigure = _boardController.blackFigures
              .firstWhere((element) => element.id == event.figure.id);

          tapToStep(s.Step(
              coordinates: Coordinates(x: 0, y: 0),
              x: event.x,
              y: event.y,
              canKill: event.canKill,
              figure: foundFigure));
          _boardController.refery.whoseMove = TeamEnum.white;
          //TODO: ?????????????????????? ?? ???????? ????????????????
        } else if (event.figure.team == TeamEnum.white &&
            _boardController.myTeam == TeamEnum.black &&
            _boardController.refery.whoseMove == event.figure.team) {
          print('white hod');
          foundFigure = _boardController.whiteFigures
              .firstWhere((element) => element.id == event.figure.id);
          tapToStep(
              s.Step(
                  coordinates: Coordinates(x: 0, y: 0),
                  x: event.x,
                  y: event.y,
                  canKill: event.canKill,
                  figure: foundFigure),
              true);
          _boardController.refery.whoseMove = TeamEnum.black;
        }
      },
    );
  }

  void disposeStream() {
    print('dispose streams');

    lastStepStream.cancel();
    listenOtherPlayerStream.cancel();
    state.enemyPlayer = null;
    state.isExit = null;
  }
}
