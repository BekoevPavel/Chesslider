import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/common/configuration.dart';

import '../../domain/entities/figure_entity.dart';

class FigureWidget extends StatelessWidget {
  const FigureWidget({super.key, required this.figureEntity});

  final FigureEntity figureEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameCubit>().showStep(figureEntity);
      },
      child: Container(
        width: Configuration.cellSize,
        height: Configuration.cellSize,
        decoration: BoxDecoration(
          color: figureEntity.color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 2, color: figureEntity.borderColor),
        ),
        child: Center(
          child: Text(
            figureEntity.value.toString(),
            style: TextStyle(color: figureEntity.borderColor),
          ),
        ),
      ),
    );
  }
}
