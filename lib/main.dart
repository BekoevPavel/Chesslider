import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/app_provider/app_provider.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
// Import the generated file

import 'package:flutter_chesslider_beta0/test_widgets.dart';

import 'core/lib/core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1024 * 1024 * 300;
  await AppDependencies().setDependencies();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  // try {
  //   final credential =
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: 'pablank132@bk.ru',
  //     password: '12345678',
  //   );
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(credential.user!.uid)
  //       .set({
  //     'userID': credential.user!.uid,
  //     'email': credential.user!.email,
  //     'username': 'Pavel',
  //   });
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'weak-password') {
  //     print('The password provided is too weak.');
  //   } else if (e.code == 'email-already-in-use') {
  //     print('The account already exists for that email.');
  //   }
  // } catch (e) {
  //   print('reeriir $e');
  // }

  runApp(const MyApp());

  AutoRouterDelegate(
    AppRouter(),
    navigatorObservers: () => [HeroController()],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppProvider(
        child: MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        AppRouter(),
        navigatorObservers: () => [HeroController()],
      ),
      routeInformationParser: AppRouter().defaultRouteParser(),
    ));
  }
}
