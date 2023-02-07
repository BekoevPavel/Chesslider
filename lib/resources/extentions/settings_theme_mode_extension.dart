import 'package:flutter/material.dart';

import '../../domain/enums/settings_theme_mode.dart';

extension SettingsThemeModeExtension on SettingsThemeMode {
  ThemeMode get theme {
    switch (this) {
      case SettingsThemeMode.system:
        return ThemeMode.system;

      case SettingsThemeMode.light:
        return ThemeMode.light;

      case SettingsThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  // String themeName(AppLocalizations localizations) {
  //   switch (this) {
  //     case SettingsThemeMode.dark:
  //       return localizations.alwaysDark;
  //
  //     case SettingsThemeMode.light:
  //       return localizations.alwaysLight;
  //
  //     case SettingsThemeMode.system:
  //       return localizations.likeSystem;
  //   }
  // }
}
