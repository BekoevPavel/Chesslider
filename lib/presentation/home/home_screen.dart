import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/localization/localization.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../localization/app_locale.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ln: ${baseLocalization.currentLocale}');
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.success && state.navigate == AuthNavigate.localAuth) {
          context.replaceRoute(const SignInRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 40,
            title: const Text('Chesslider'),
            //leading: IconButton(onPressed: () {}, icon: const Icon(Icons.chat)),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(HomeSignOut());
                  },
                  icon: const Icon(Icons.logout))
            ]),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: null,
                  //     () {
                  //   context.pushRoute(GameRoute(
                  //       myTeam: TeamEnum.black, gameType: GameType.offline));
                  // },
                  child: Text(AppLocale.gameOnOneDevice.getString(context))),
              TextButton(
                  onPressed: null,
                  child: Text(AppLocale.randomGame.getString(context))),
              TextButton(
                  onPressed: () {
                    context.pushRoute(const CreateRoomRoute());
                  },
                  child: Text(AppLocale.gameWithFriend.getString(context))),
              TextButton(
                  onPressed: null,
                  child: Text(AppLocale.tournament.getString(context))),
            ],
          ),
        ),
      ),
    );
  }
}
