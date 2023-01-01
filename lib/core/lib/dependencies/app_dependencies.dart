part of core;

GetIt injection = GetIt.I;

class AppDependencies {
  static final AppDependencies instance = AppDependencies._();

  factory AppDependencies() => instance;

  AppDependencies._();

  Future<void> setDependencies() async {
    final AuthRepository authRepository = AuthRepositoryImpl();
    final GameRepository gameRepository = GameRepositoryImpl();
    injection.registerLazySingleton<AuthRepository>(() => authRepository);
    injection.registerLazySingleton<GameRepository>(() => gameRepository);
  }
}
