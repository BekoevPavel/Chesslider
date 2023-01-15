import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/screens/sign_up_screen.dart';
import 'package:flutter_chesslider_beta0/presentation/home/home_screen.dart';
import 'package:flutter_chesslider_beta0/presentation/splash/screens/splash_screen.dart';

import '../../domain/enums/team_enum.dart';
import '../auth/screens/sign_in_screen.dart';
import '../game/screens/game_screen.dart';
import '../home/create_room_screen.dart';



part 'app_router.gr.dart';

@CustomAutoRouter(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: SplashScreen, initial: true),
      AutoRoute(page: HomeScreen),
      AutoRoute(page: SignInScreen),
      AutoRoute(page: SignUpScreen),
      AutoRoute(page: GameScreen),
      AutoRoute(page: CreateRoomScreen),
    ])
class AppRouter extends _$AppRouter {
  factory AppRouter() => _instance;

  AppRouter._();

  static final AppRouter _instance = AppRouter._();
}
