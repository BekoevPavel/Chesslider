import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_bloc.dart';

import '../game/bloc/game_cubit.dart';
import '../splash/bloc/splash_bloc.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthBloc(injection()),
      ),
      BlocProvider(
        create: ((context) => GameCubit()),
      ),
      BlocProvider(
        create: (context) => SplashBloc(injection(),injection())..add(SplashEvent()),
      ),
    ], child: child);
  }
}
