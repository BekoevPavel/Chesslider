import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_chesslider_beta0/presentation/theme/theme_state.dart';

import '../../domain/enums/settings_theme_mode.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      :
//_themeUseCase = themeUseCase,
        super(const ThemeState(SettingsThemeMode.system));

//final ThemeUseCase _themeUseCase;

  SettingsThemeMode get themeMode => state.themeMode;

  Future<void> changeTheme(SettingsThemeMode themeMode) async {
    emit(ThemeState(themeMode));
   // await _themeUseCase.changeTheme(themeMode);
  }

  void getTheme() {
    //final themeMode = _themeUseCase.getThemeMode();
    emit(ThemeState(themeMode));
  }
}
