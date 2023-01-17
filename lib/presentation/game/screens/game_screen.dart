import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/board_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/otp_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/game/widgets/score_widget.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:get_it/get_it.dart';

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
        // TODO: implement listener}
        if (state.success && state.navigate == AuthNavigate.menu) {
          context.replaceRoute(const HomeRoute());
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16),
                  child: IconButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(ExitFromRoom());
                      },
                      icon: const Icon(Icons.arrow_back))),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: OtpWidget(),
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
    );
  }
}
