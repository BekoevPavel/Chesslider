import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/theme/theme_cubit.dart';
import 'package:flutter_chesslider_beta0/presentation/theme/theme_state.dart';
import 'package:flutter_chesslider_beta0/resources/extentions/build_context_extension.dart';

import '../../domain/enums/settings_theme_mode.dart';
import '../../resources/app_theme.dart';

class ThemeWidget extends StatefulWidget {
  final Widget Function(SettingsThemeMode) builder;

  const ThemeWidget({Key? key, required this.builder}) : super(key: key);

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    context.read<ThemeCubit>().getTheme();
    // context.theme.androidBiometryIcon;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: _themeListener,
      builder: (_, state) => widget.builder(state.themeMode),
    );
  }

  void _themeListener(_, ThemeState state) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    switch (state.themeMode) {
      case SettingsThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiOverlayStyleDark);
        break;

      case SettingsThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(
            AppTheme.systemUiOverlayStyleLight);
        break;

      case SettingsThemeMode.system:
        SystemChrome.setSystemUIOverlayStyle(
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? AppTheme.systemUiOverlayStyleDark
              : AppTheme.systemUiOverlayStyleLight,
        );
        break;
    }
  }
}
