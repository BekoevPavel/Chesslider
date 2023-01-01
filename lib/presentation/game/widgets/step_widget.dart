import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_entity.dart';

import '../../../domain/entities/step_entity.dart';
import '../bloc/game_cubit.dart';

class StepWidget extends StatelessWidget {
  final StepEntity stepEntity;
  final double cellWidth;

  const StepWidget({
    required this.cellWidth,
    super.key,
    required this.stepEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameCubit>().tapToStep(stepEntity);
      },
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: cellWidth,
          height: cellWidth,
          decoration: BoxDecoration(
              color: stepEntity.canKill == null ? Colors.green : Colors.red,
              border: Border.all(width: 2)),
        ),
      ),
    );
  }
}
