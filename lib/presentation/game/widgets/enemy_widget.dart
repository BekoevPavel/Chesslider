import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';

import '../../../core/lib/core.dart';

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        print('state. ${state.isExit}');
        if (state.isExit == true) {
          print('out from room');
          _applyDisidion(context);
        }
      },
      builder: (context, state) {
        if (state.enemyPlayer != null) {
          return Container(
            color: Colors.green,
            child: Text(
                'nickname: ${state.enemyPlayer?.username}  rating: ${state.enemyPlayer?.rating}'),
          );
        }
        return const SizedBox();
      },
    );
  }

  Future<void> _applyDisidion(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Игрок покинул комнату'),
          content: Column(
            children: [],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Выйти'),
              onPressed: () {
                AppDependencies().removeBoardController();
                context.navigateBack();
              },
            ),
          ],
        );
      },
    );
  }
}
