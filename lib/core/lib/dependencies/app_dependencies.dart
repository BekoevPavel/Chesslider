part of core;

GetIt injection = GetIt.I;

class AppDependencies {
  static final AppDependencies instance = AppDependencies._();

  factory AppDependencies() => instance;

  AppDependencies._();

  Future<void> setDependencies() async {
    final AuthRepository authRepository = AuthRepositoryImpl();
    final GameRepository gameRepository = GameRepositoryImpl();
    final RoomRepository roomRepository = RoomsRepositoryImpl();
    List<PlayerEntity> players = [];
    List<RoomEntity> roomEntity = [];

    //Repositories
    injection.registerLazySingleton<AuthRepository>(() => authRepository);
    injection.registerLazySingleton<GameRepository>(() => gameRepository);
    injection.registerLazySingleton<RoomRepository>(() => roomRepository);

    //Variables
    injection.registerLazySingleton<List<PlayerEntity>>(() => players);
    injection.registerLazySingleton<List<RoomEntity>>(() => roomEntity);
  }

  Future<void> addBoardController(BoardController boardController) async {
    if (injection.isRegistered<BoardController>()) {
      injection.unregister<BoardController>();
    }
    injection.registerLazySingleton<BoardController>(() => boardController);
  }

  Future<void> removeBoardController() async {
    injection.unregister<BoardController>();
  }
}
