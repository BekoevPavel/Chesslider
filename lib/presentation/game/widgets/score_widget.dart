import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/score_bloc.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
      builder: (context, state) {
        if (state.whiteWin || state.blackWin || state.draw) {
          return _GameOverWidget(context, state);
        }
        if (state.success || state.initial) {
          return Container(
            // color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Белые',
                      style: TextStyle(
                          color: state.whoseMove == TeamEnum.white
                              ? Colors.green
                              : Colors.red),
                    ),
                    Text(state.whiteScore.toString()),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Ход'),
                    Text('Счет'),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Черные',
                      style: TextStyle(
                          color: state.whoseMove == TeamEnum.black
                              ? Colors.green
                              : Colors.red),
                    ),
                    Text(state.blackScore.toString()),
                  ],
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _GameOverWidget(BuildContext context, ScoreState state) {
    if (state.success && state.whiteWin) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Белые победили!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.green),
            ),
            Text(
              '${state.whiteScore} / ${state.blackScore}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      );
    }
    if (state.success && state.blackWin) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Черные победили!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.green),
            ),
            Text(
              '${state.blackScore} / ${state.whiteScore}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      );
    }
    if (state.success && state.draw) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ничья!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.yellow),
            ),
            Text(
              '${state.blackScore} / ${state.whiteScore}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
