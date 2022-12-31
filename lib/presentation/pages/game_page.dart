import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/presentation/widgets/board_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: 3.14,
                child: const BoardWidget(),
              )),
        ],
      ),
    );
  }
}
