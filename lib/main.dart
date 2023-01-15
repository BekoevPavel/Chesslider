import 'dart:io';
import 'dart:math';
import 'package:statsfl/statsfl.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/data/repositories/game_repository_impl.dart';
import 'package:flutter_chesslider_beta0/data/repositories/rooms_repository_impl.dart';
import 'package:flutter_chesslider_beta0/presentation/app_provider/app_provider.dart';
import 'package:flutter_chesslider_beta0/presentation/game/bloc/game_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
// Import the generated file

import 'package:flutter_chesslider_beta0/test_widgets.dart';
import 'package:http/http.dart' as http;

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

  runApp(StatsFl(child: const MyApp(),align: Alignment.bottomLeft,));

  double Rb = 250;
  double Ra = 250;
  double K = 16;
  double Sa = 0.5;
  var Ea = 1 / (1 + pow(10, ((Rb - Ra) / 400)));
  var RaNew = Ra + K * (Sa - Ea);

  AutoRouterDelegate(
    AppRouter(),
    navigatorObservers: () => [HeroController()],
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Future<String?> getPublicIP() async {
//   final ipv4 = await Ipify.ipv4();
//   print(ipv4);
//   try {
//     const url = 'https://api.ipify.org';
//     var response = await http.get(Uri.https(url));
//     if (response.statusCode == 200) {
//       // The response body is the IP in plain text, so just
//       // return it as-is.
//       return response.body;
//     } else {
//       // The request failed with a non-200 code
//       // The ipify.org API has a lot of guaranteed uptime
//       // promises, so this shouldn't ever actually happen.
//       print(response.statusCode);
//       print(response.body);
//       return null;
//     }
//   } catch (e) {
//     // Request failed due to an error, most likely because
//     // the phone isn't connected to the internet.
//     print(e);
//     return null;
//   }
// }

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    final isBackground = state == AppLifecycleState.paused;
    if (state == AppLifecycleState.detached) {
      print('detached');
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      RoomsRepositoryImpl().exitFromRoom();
    }

    if (isBackground) {
      print('isBackground');
    }
  }

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
