import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/app_provider/game_provider.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/board_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/enemy_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/otp_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/score_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';

import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_state.dart';

class GameScreen extends StatelessWidget {
  final TeamEnum myTeam;
  final GameType gameType;

  const GameScreen({super.key, required this.myTeam, required this.gameType});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        print('коннект листенинг');

        if (state.success && state.navigate == AuthNavigate.menu) {
          // context.pushRoute(const HomeRoute());
          context.popRoute(HomeRoute);
        }
      },
      child: GameProvider(
        homeBloc: context.read<HomeBloc>(),
        child: Scaffold(
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 16),
                    child: IconButton(
                        onPressed: () {
                          print('pop route');
                          context.read<HomeBloc>().add(ExitFromRoom());
                          // context.read<GameCubit>().disposeStream();
                        },
                        icon: const Icon(Icons.arrow_back))),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: OtpWidget(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: EnemyWidget(),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: ScoreWidget(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: myTeam == TeamEnum.white ? 3.14 : 0,
                  child: BoardWidget(
                    myTeam: myTeam,
                    gameType: gameType,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
