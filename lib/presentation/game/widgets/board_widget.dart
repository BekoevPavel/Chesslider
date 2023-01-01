import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/step_widget.dart';

import 'figure_widget.dart';


LabeledGlobalKey board_key = LabeledGlobalKey('board_key');

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = 28;
    return GestureDetector(
      onTapDown: (details) {},
      child: OrientationBuilder(builder: ((context, orientation) {
        final width = orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;
        return Container(
          key: board_key,
          height: width,
          width: width,
          padding: EdgeInsets.all(padding),
          decoration: const BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage('assets/images/board.png'),
            ),
          ),
          child: FutureBuilder<double>(
            future: getWidth(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              context
                  .read<GameCubit>()
                  .startGame(snapshot.data! - (padding * 2));
              return CustomPaint(
                  painter:
                      BoardPainter(boardWidth: snapshot.data! - (padding * 2)),
                  child: _generateFigures(
                      boardWidth: snapshot.data! - (padding * 2)));
            }),
          ),
        );
      })),
    );
  }

  Widget _generateFigures({required double boardWidth}) {
    final cell = boardWidth / 8;
    double figureSize = 24.0;

    // BoardController boardController =
    //     BoardController(boardWidth: boardWidth, figureSize: 24);

    double step = (cell - figureSize) / 2;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        if (state is LoadedGame) {

          return Stack(
            children: [
              // My figure
              for (int i = 0; i < state.boardController.myFigures.length; i++)
                Positioned(
                  left: state.boardController.myFigures[i].figureCoordinaties.x,
                  top: state.boardController.myFigures[i].figureCoordinaties.y,
                  child:
                      FigureWidget(figureEntity: state.boardController.myFigures[i]),
                ),
              // Other figure
              for (int i = 0; i < state.boardController.otherFigures.length; i++)
                Positioned(
                  left: state.boardController.otherFigures[i].figureCoordinaties.x,
                  top: state.boardController.otherFigures[i].figureCoordinaties.y,
                  child: FigureWidget(
                      figureEntity: state.boardController.otherFigures[i]),
                ),
              for (int i = 0; i < state.boardController.steps.length; i++)
                Positioned(
                  left: state.boardController.steps[i].coordinatiesEntity.x,
                  top: state.boardController.steps[i].coordinatiesEntity.y,
                  child: StepWidget(
                      cellWidth: cell,
                      stepEntity: state.boardController.steps[i]),
                ),
            ],
          );
        }
        return const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Future<double> getWidth() async {
  await Future.delayed(const Duration(microseconds: 10));

  return board_key.currentContext!.size!.width;
}

class BoardPainter extends CustomPainter {
  double boardWidth;

  BoardPainter({required this.boardWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // canvas.drawLine(const Offset(0, 0), Offset(boardWidth, boardWidth), paint);
    drowVertical(paint, canvas);
    drowHorizontal(paint, canvas);
  }

  void drowVertical(Paint paint, Canvas canvas) {
    double diference = boardWidth / 8;
    for (var i = 0; i < 9; i++) {
      canvas.drawLine(
          Offset(i * diference, 0), Offset(i * diference, boardWidth), paint);
    }
  }

  void drowHorizontal(Paint paint, Canvas canvas) {
    double diference = boardWidth / 8;
    for (var i = 0; i < 9; i++) {
      canvas.drawLine(
          Offset(0, i * diference), Offset(boardWidth, i * diference), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
