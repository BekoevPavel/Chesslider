import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/widgets/board_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Align(alignment: Alignment.center, child: BoardWidget())
        ],
      ),
    );
  }
}
