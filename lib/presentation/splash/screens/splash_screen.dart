import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/game/screens/game_screen.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:flutter_chesslider_beta0/presentation/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.navigate == AuthNavigate.menu) {
          context.router.replace(const HomeRoute());
        } else {
          context.router.replace(const SignInRoute());
        }
      },
      child: const CircularProgressIndicator(),
    );
  }
}
