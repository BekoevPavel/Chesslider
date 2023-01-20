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

  Future<void> setRoom(Room room) async {
    if (injection.isRegistered<Room>()) {
      injection.unregister<Room>();
    }

    injection.registerLazySingleton<Room>(() => room);
  }

  Room getRoom() {
    return injection.get<Room>();
  }

  Future<void> setMyPlayer(Player player) async {
    if (injection.isRegistered<Player>(instanceName: 'myPlayer')) {
      injection.unregister<Player>(instanceName: 'myPlayer');
    }

    injection.registerLazySingleton<Player>(() => player,
        instanceName: 'myPlayer');
  }

  Future<void> setEnemyPlayer(Player player) async {
    if (injection.isRegistered<Player>(instanceName: 'enemyPlayer')) {
      injection.unregister<Player>(instanceName: 'enemyPlayer');
    }

    injection.registerLazySingleton<Player>(() => player,
        instanceName: 'enemyPlayer');
  }

  Player getMyPlayer() {
    return injection.get<Player>(instanceName: 'myPlayer');
  }

  Player getEnemyPlayer() {
    return injection.get<Player>(instanceName: 'enemyPlayer');
  }

  Future<void> addBoardController(BoardController boardController) async {
    if (injection.isRegistered<BoardController>()) {
      injection.unregister<BoardController>();
    }
    injection.registerLazySingleton<BoardController>(() => boardController);
  }

  BoardController getBoardController() {
    return injection.get<BoardController>();
  }

  Future<void> removeBoardController() async {
    injection.unregister<BoardController>();
  }
}
