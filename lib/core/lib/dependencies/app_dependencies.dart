part of core;

GetIt injection = GetIt.I;

class AppDependencies {
  static final AppDependencies instance = AppDependencies._();

  factory AppDependencies() => instance;

  AppDependencies._();

  Future<void> setDependencies() async {
    final AuthRepository authRepository = AuthRepositoryImpl();
    final GameRepository gameRepository = GameRepositoryImpl();
    final BoardController boardController = BoardController(boardWidth: 0);
    List<PlayerEntity> players = [];
    List<RoomEntity> roomEntity = [];

    injection.registerLazySingleton<AuthRepository>(() => authRepository);
    injection.registerLazySingleton<GameRepository>(() => gameRepository);
    injection.registerLazySingleton<List<PlayerEntity>>(() => players);
    injection.registerLazySingleton<List<RoomEntity>>(() => roomEntity);
    injection.registerLazySingleton<BoardController>(() => boardController);
  }
}
