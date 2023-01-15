import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/step_widget.dart';
import 'package:get_it/get_it.dart';

import 'figure_widget.dart';

LabeledGlobalKey board_key = LabeledGlobalKey('board_key');

class BoardWidget extends StatefulWidget {
  final TeamEnum myTeam;
  final GameType gameType;

  const BoardWidget({Key? key, required this.myTeam, required this.gameType})
      : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await context.read<GameCubit>().disposeStream();
  }

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
                  .startGame(snapshot.data! - (padding * 2), widget.myTeam);
              return CustomPaint(
                painter:
                    BoardPainter(boardWidth: snapshot.data! - (padding * 2)),
                child: _generateFigures(
                  boardWidth: snapshot.data! - (padding * 2),
                ),
              );
            }),
          ),
        );
      })),
    );
  }

  Widget _generateFigures({required double boardWidth}) {
    BoardController boardController = GetIt.instance.get<BoardController>();
    final cell = boardWidth / 8;
    double figureSize = 24.0;

    double step = (cell - figureSize) / 2;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        if (state is LoadedGame) {
          return Stack(
            children: [
              // My figure
              for (int i = 0; i < boardController.whiteFigures.length; i++)
                Positioned(
                  left: boardController.whiteFigures[i].figureCoordinaties.x,
                  top: boardController.whiteFigures[i].figureCoordinaties.y,
                  child: FigureWidget(
                      cellSize: cell,
                      gameType: widget.gameType,
                      myTeam: widget.myTeam,
                      figureEntity: boardController.whiteFigures[i]),
                ),
              // Other figure
              for (int i = 0; i < boardController.blackFigures.length; i++)
                Positioned(
                  left: boardController.blackFigures[i].figureCoordinaties.x,
                  top: boardController.blackFigures[i].figureCoordinaties.y,
                  child: FigureWidget(
                      cellSize: cell,
                      gameType: widget.gameType,
                      myTeam: widget.myTeam,
                      figureEntity: boardController.blackFigures[i]),
                ),
              for (int i = 0; i < boardController.steps.length; i++)
                Positioned(
                  left: boardController.steps[i].coordinatiesEntity.x,
                  top: boardController.steps[i].coordinatiesEntity.y,
                  child: StepWidget(
                      cellWidth: cell, stepEntity: boardController.steps[i]),
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
