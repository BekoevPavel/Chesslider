import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:get_it/get_it.dart';

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
    // TODO: implement copyWith
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

  ScoreBloc() : super(ScoreState(status: BaseStatus.initial)) {
    on<AddStepEvent>((event, emit) {
      _boardController = GetIt.instance.get<BoardController>();
      emit(state.copyWith(status: BaseStatus.loading));
      final whiteScore = getScore(_boardController.whiteFigures);
      final blackScore = getScore(_boardController.blackFigures);
      print('whiteScore: $whiteScore , blackScore: $blackScore');
      bool draw = false;
      bool whiteWin = false;
      bool blackWin = false;

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

  int getScore(List<FigureEntity> figures) {
    int score = 0;
    if (figures.isNotEmpty && figures.first.team == TeamEnum.white) {
      final finalWhite = figures.where((figure) => figure.y == 7).toList();
      for (final figure in finalWhite) {
        score = score + figure.weight;

        AppLogger.figureReachedTheEnd(figure);
      }
    }
    if (figures.isNotEmpty && figures.first.team == TeamEnum.black) {
      final finalBlack = figures.where((figure) => figure.y == 0).toList();
      for (final figure in finalBlack) {
        score = score + figure.weight;

        AppLogger.figureReachedTheEnd(figure);
      }
    }

    return score;
  }
}
