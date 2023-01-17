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

    //Repositories
    injection.registerLazySingleton<AuthRepository>(() => authRepository);
    injection.registerLazySingleton<GameRepository>(() => gameRepository);
    injection.registerLazySingleton<RoomRepository>(() => roomRepository);

    //Variables
  }

  Future<void> setRoom(RoomEntity room) async {
    if (injection.isRegistered<RoomEntity>()) {
      injection.unregister<RoomEntity>();
    }

    injection.registerLazySingleton<RoomEntity>(() => room);
  }

  RoomEntity getRoom() {
    return injection.get<RoomEntity>();
  }

  Future<void> setMyPlayer(PlayerEntity player) async {
    if (injection.isRegistered<BoardController>(instanceName: 'myPlayer')) {
      injection.unregister<PlayerEntity>(instanceName: 'myPlayer');
    }

    injection.registerLazySingleton<PlayerEntity>(() => player,
        instanceName: 'myPlayer');
  }

  Future<void> setEnemyPlayer(PlayerEntity player) async {
    if (injection.isRegistered<BoardController>(instanceName: 'enemyPlayer')) {
      injection.unregister<PlayerEntity>(instanceName: 'enemyPlayer');
    }

    injection.registerLazySingleton<PlayerEntity>(() => player,
        instanceName: 'enemyPlayer');
  }

  PlayerEntity getMyPlayer() {
    return injection.get<PlayerEntity>(instanceName: 'myPlayer');
  }

  PlayerEntity getEnemyPlayer() {
    return injection.get<PlayerEntity>(instanceName: 'enemyPlayer');
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
