import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/common/configuration.dart';

import '../../../domain/entities/figure_entity.dart';

class FigureWidget extends StatelessWidget {
  final TeamEnum myTeam;
  final GameType gameType;
  final double cellSize;

  const FigureWidget(
      {super.key,
      required this.figureEntity,
      required this.myTeam,
      required this.gameType,
      required this.cellSize});

  final FigureEntity figureEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameType == GameType.online && figureEntity.team == myTeam) {
          context.read<GameCubit>().showStep(figureEntity);
        }
        if (gameType == GameType.offline) {
          context.read<GameCubit>().showStep(figureEntity);
        }
      },
      child: Container(
        width: cellSize,
        height: cellSize,
        color: Colors.transparent,
        child: Container(
          //TODO: Сделать коафициент для размера фигур!
          margin: const EdgeInsets.all(7),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: figureEntity.color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 2, color: figureEntity.borderColor),
          ),
          child: Center(
            child: Transform.rotate(
              angle: myTeam == TeamEnum.white ? 3.14 : 0,
              child: Text(
                figureEntity.value.toString(),
                style: TextStyle(color: figureEntity.borderColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
