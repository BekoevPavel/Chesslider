import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/entities/step_entity.dart';

class StepWidget extends StatelessWidget {
  //final StepEntity stepEntity;
  final double cellWidth;

  const StepWidget({
    required this.cellWidth,

    // required this.stepEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        width: cellWidth,
        height: cellWidth,
        decoration:
            BoxDecoration(color: Colors.green, border: Border.all(width: 2)),
      ),
    );
  }
}
