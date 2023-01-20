import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dto/step/step.dart' as s;
import '../bloc/game_cubit.dart';

class StepWidget extends StatelessWidget {
  final s.Step step;
  final double cellWidth;

  const StepWidget({
    required this.cellWidth,
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameCubit>().tapToStep(step);
      },
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: cellWidth,
          height: cellWidth,
          decoration: BoxDecoration(
              color: step.canKill == null ? Colors.green : Colors.red,
              border: Border.all(width: 2)),
        ),
      ),
    );
  }
}
