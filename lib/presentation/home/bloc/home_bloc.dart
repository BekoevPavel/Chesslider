import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_state.dart';

import '../../../core/lib/core.dart';
import '../../../data/dto/room/room.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/game_repository.dart';
import '../../../domain/repositories/rooms_repository.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final AuthRepository _authRepository;
  final GameRepository _gameRepository;
  final RoomRepository _roomRepository;
  bool wasExit = false;

  HomeBloc(AuthRepository authRepository, GameRepository gameRepository,
      RoomRepository roomRepository)
      : _authRepository = authRepository,
        _gameRepository = gameRepository,
        _roomRepository = roomRepository,
        super(
            HomeState(status: BaseStatus.initial, gameType: GameType.offline)) {
    on<HomeSignOut>((event, emit) async {
      emit(state.copyWith(
          status: BaseStatus.loading, navigate: AuthNavigate.menu));
      await _authRepository.singOut();
      emit(state.copyWith(
          status: BaseStatus.success, navigate: AuthNavigate.localAuth));
    });

    on<HomeFirstStart>(_firstStart);

    on<HomeCreateRoom>(_createRoom);

    on<ConnectToRoom>(_connectToRoom);

    on<ExitFromRoom>(_exitFromRoom);
  }

  Future<void> _firstStart(
      HomeFirstStart event, Emitter<HomeState> emit) async {
    try {
      final user = await _authRepository.getPlayer1();
      // GetIt.instance.get<List<PlayerEntity>>().clear();
      // GetIt.instance.get<List<PlayerEntity>>().addAll([user]);
      AppDependencies().setMyPlayer(user);
    } catch (error, stackTrace) {}
  }

  Future<void> _connectToRoom(
      ConnectToRoom event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      Room room = await _roomRepository.connectToRoom(event.code);
      wasExit = false;
      AppDependencies().setRoom(room);
      await Future.delayed(const Duration(milliseconds: 250));

      emit(state.copyWith(
          status: BaseStatus.success,
          navigate: AuthNavigate.game,
          gameType: GameType.online,
          team: TeamEnum.black));
      print('connect to room');
    } on FirebaseAuthException catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  Future<void> _createRoom(
      HomeCreateRoom event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(
        status: BaseStatus.loading,
        navigate: AuthNavigate.menu,
        gameType: GameType.online,
        team: TeamEnum.white,
      ));
      wasExit = false;
      await _roomRepository.createRoom();

      emit(state.copyWith(
          status: BaseStatus.success, navigate: AuthNavigate.game));
    } on FirebaseAuthException catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  Future<void> _exitFromRoom(
      ExitFromRoom event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(
          status: BaseStatus.loading, navigate: AuthNavigate.game));

      wasExit = true;

      await _roomRepository.exitFromRoom();
      await AppDependencies().removeBoardController();
      emit(state.copyWith(
          status: BaseStatus.success, navigate: AuthNavigate.menu));
    } on FirebaseAuthException catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }
}
