import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/data/dto/player/player.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:get_it/get_it.dart';

import '../../../data/dto/figure/figure.dart';
import '../../../domain/repositories/game_repository.dart';

class ScoreEvent {}

class AddStepEvent extends ScoreEvent {
  bool canMove;

  AddStepEvent({required this.canMove});
}

class ScoreState extends BaseState {
  int whiteScore;
  int blackScore;

  bool whiteWin;
  bool blackWin;
  TeamEnum whoseMove;

  bool draw = false;

  ScoreState({
    required super.status,
    this.whiteScore = 0,
    this.blackScore = 0,
    this.draw = false,
    this.whiteWin = false,
    this.blackWin = false,
    this.whoseMove = TeamEnum.white,
  });

  @override
  ScoreState copyWith(
      {BaseStatus? status,
      int? whiteScore,
      int? blackScore,
      bool? blackWin,
      bool? whiteWin,
      bool? draw,
      TeamEnum? whoseMove}) {
    return ScoreState(
        status: status ?? this.status,
        whiteScore: whiteScore ?? this.whiteScore,
        blackScore: blackScore ?? this.blackScore,
        blackWin: blackWin ?? this.blackWin,
        whiteWin: whiteWin ?? this.whiteWin,
        draw: draw ?? this.draw,
        whoseMove: whoseMove ?? this.whoseMove);
  }
}

class ScoreBloc extends BaseBloc<ScoreEvent, ScoreState> {
  late BoardController _boardController;
  GameRepository _gameRepository;
  bool draw = false;
  bool whiteWin = false;
  bool blackWin = false;

  ScoreBloc(GameRepository gameRepository)
      : _gameRepository = gameRepository,
        super(ScoreState(status: BaseStatus.initial)) {
    on<AddStepEvent>((event, emit) {
      _boardController = GetIt.instance.get<BoardController>();
      emit(state.copyWith(status: BaseStatus.loading));
      final whiteScore = getScore(_boardController.whiteFigures);
      final blackScore = getScore(_boardController.blackFigures);
      print('whiteScore: $whiteScore , blackScore: $blackScore');

      if (!event.canMove) {
        if (whiteScore == blackScore) {
          draw = true;
          AppLogger.whoWin(TeamEnum.white, whiteScore, blackScore);
        } else if (whiteScore > blackScore) {
          whiteWin = true;
          AppLogger.whoWin(TeamEnum.white, whiteScore, blackScore);
        } else if (blackScore > whiteScore) {
          blackWin = true;
          AppLogger.whoWin(TeamEnum.black, whiteScore, blackScore);
        }
        calculateNewData();
        print('gameEnd');
      }
      emit(state.copyWith(
          status: BaseStatus.success,
          whoseMove: _boardController.refery.whoseMove,
          whiteScore: whiteScore,
          blackScore: blackScore,
          blackWin: blackWin,
          whiteWin: whiteWin,
          draw: draw));
    });
  }

  void calculateNewData() {
    Player player = AppDependencies().getMyPlayer();

    if (blackWin && _boardController.myTeam == TeamEnum.black) {
      print('играю за черных и выйграл');
      player.winsCount = player.winsCount + 1;
    }
    if (blackWin && _boardController.myTeam == TeamEnum.white) {
      print('играю за белых и проиграл');
      player.lossCount = player.lossCount + 1;
    }
    if (whiteWin && _boardController.myTeam == TeamEnum.black) {
      print('играю за черных и проиграл');
      player.lossCount = player.lossCount + 1;
    }
    if (whiteWin && _boardController.myTeam == TeamEnum.white) {
      print('играю за белых и выйграл');
      player.winsCount = player.winsCount + 1;
    }

    if (draw) {
      print('ничья');
      player.drawCount = player.drawCount + 1;
    }
  }

  int getScore(List<Figure> figures) {
    int score = 0;
    if (figures.isNotEmpty && figures.first.team == TeamEnum.white) {
      final finalWhite = figures.where((figure) => figure.y == 7).toList();
      for (final figure in finalWhite) {
        score = score + figure.points;

        AppLogger.figureReachedTheEnd(figure);
      }
    }
    if (figures.isNotEmpty && figures.first.team == TeamEnum.black) {
      final finalBlack = figures.where((figure) => figure.y == 0).toList();
      for (final figure in finalBlack) {
        score = score + figure.points;

        AppLogger.figureReachedTheEnd(figure);
      }
    }

    return score;
  }
}
