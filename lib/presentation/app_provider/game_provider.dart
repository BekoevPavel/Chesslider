import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_bloc.dart';

import '../../core/lib/core.dart';
import '../game/bloc/game_cubit.dart';
import '../game/bloc/score_bloc.dart';

class GameProvider extends StatelessWidget {
  final Widget child;
  final ScoreBloc scoreBloc;
  final HomeBloc _homeBloc;

  // final ScoreBloc scoreBloc;
  GameProvider({Key? key, required this.child, required HomeBloc homeBloc})
      : _homeBloc = homeBloc,
        scoreBloc = ScoreBloc(injection()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => scoreBloc,
      ),
      BlocProvider(
        create: ((context) =>
            GameCubit(injection(), injection(), scoreBloc, _homeBloc)),
      ),
    ], child: child);
  }
}
