import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_chesslider_beta0/presentation/localization/app_locale.dart';
import 'package:flutter_chesslider_beta0/presentation/localization/localization.dart';
import 'package:flutter_chesslider_beta0/presentation/theme/theme_widget.dart';
import 'package:flutter_chesslider_beta0/resources/app_theme.dart';
import 'package:flutter_chesslider_beta0/resources/extentions/settings_theme_mode_extension.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:statsfl/statsfl.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/presentation/app_provider/app_provider.dart';
import 'package:flutter_chesslider_beta0/presentation/router/app_router.dart';

// Import the generated file

import 'package:http/http.dart' as http;

import 'core/lib/core.dart';
import 'firebase_options.dart';

_onTranslatedLanguage(Locale? locale) {
  print('change locale: $locale');
}

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

  /// the setState function here is a must to add

  runApp(
    StatsFl(
      align: Alignment.bottomLeft,
      child: const MyApp(),
    ),
  );
  //TODO: АЛГОРИТМ РЕЙТИНГА
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

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  String? publicIP = '';

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    var platformLanguage = Platform.localeName;
    print(platformLanguage);
    //ru_US
    //en_US
    baseLocalization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ru', AppLocale.RU),
      ],
      initLanguageCode: platformLanguage == 'ru_US' ? 'ru' : 'en',
    );
    // baseLocalization.translate('ru');

    baseLocalization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    //TODO: Удаление комнаты при закрытие приложения
    // final isBackground = state == AppLifecycleState.paused;
    // if (state == AppLifecycleState.detached) {
    //   print('detached');
    // }
    //
    // if (state == AppLifecycleState.inactive ||
    //     state == AppLifecycleState.detached) {
    //   RoomsRepositoryImpl().exitFromRoom();
    // }
    //
    // if (isBackground) {
    //   print('isBackground');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
        child: ThemeWidget(
      builder: (themeMode) => MaterialApp.router(
        theme: AppTheme.mainTheme,
        themeMode: themeMode.theme,
        darkTheme: AppTheme.darkTheme,
        supportedLocales: baseLocalization.supportedLocales,
        localizationsDelegates: baseLocalization.localizationsDelegates,
        routerDelegate: AutoRouterDelegate(
          AppRouter(),
          navigatorObservers: () => [HeroController()],
        ),
        routeInformationParser: AppRouter().defaultRouteParser(),
      ),
    ));
  }
}
//TODO: ДОбавить ThemeWidget для контроля тем.
