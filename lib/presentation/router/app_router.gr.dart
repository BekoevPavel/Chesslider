// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignInRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SignUpRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const SignUpScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return CustomPage<dynamic>(
        routeData: routeData,
        child: GameScreen(
          key: args.key,
          myTeam: args.myTeam,
          gameType: args.gameType,
        ),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CreateRoomRoute.name: (routeData) {
      return CustomPage<dynamic>(
        routeData: routeData,
        child: const CreateRoomScreen(),
        transitionsBuilder: TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home-screen',
        ),
        RouteConfig(
          SignInRoute.name,
          path: '/sign-in-screen',
        ),
        RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-screen',
        ),
        RouteConfig(
          GameRoute.name,
          path: '/game-screen',
        ),
        RouteConfig(
          CreateRoomRoute.name,
          path: '/create-room-screen',
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-screen',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-screen',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [GameScreen]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    required TeamEnum myTeam,
    required GameType gameType,
  }) : super(
          GameRoute.name,
          path: '/game-screen',
          args: GameRouteArgs(
            key: key,
            myTeam: myTeam,
            gameType: gameType,
          ),
        );

  static const String name = 'GameRoute';
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.myTeam,
    required this.gameType,
  });

  final Key? key;

  final TeamEnum myTeam;

  final GameType gameType;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, myTeam: $myTeam, gameType: $gameType}';
  }
}

/// generated route for
/// [CreateRoomScreen]
class CreateRoomRoute extends PageRouteInfo<void> {
  const CreateRoomRoute()
      : super(
          CreateRoomRoute.name,
          path: '/create-room-screen',
        );

  static const String name = 'CreateRoomRoute';
}
