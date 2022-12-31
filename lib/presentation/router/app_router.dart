import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../pages/game_screen.dart';

part 'app_router.gr.dart';
@CustomAutoRouter(
transitionsBuilder: TransitionsBuilders.fadeIn,
replaceInRouteName: 'Screen,Route',
routes: <AutoRoute>[
  AutoRoute(page: GameScreen, initial: true),
]

)

class AppRouter extends _$AppRouter {
  factory AppRouter() => _instance;

  AppRouter._();

  static final AppRouter _instance = AppRouter._();
}