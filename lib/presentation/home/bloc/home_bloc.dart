import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_event.dart';
import 'package:flutter_chesslider_beta0/presentation/home/bloc/home_state.dart';
import 'package:get_it/get_it.dart';

import '../../../core/lib/core.dart';
import '../../../domain/entities/figure_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/game_repository.dart';
import '../../../domain/repositories/rooms_repository.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final AuthRepository _authRepository;
  final GameRepository _gameRepository;
  final RoomRepository _roomRepository;

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
      GetIt.instance.get<List<PlayerEntity>>().clear();
      GetIt.instance.get<List<PlayerEntity>>().addAll([user]);
    } catch (error, stackTrace) {}
  }

  Future<void> _connectToRoom(
      ConnectToRoom event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      RoomEntity room = await _roomRepository.connectToRoom(event.code);
      GetIt.instance.get<List<RoomEntity>>().clear();
      GetIt.instance.get<List<RoomEntity>>().addAll([room]);

      emit(state.copyWith(
          status: BaseStatus.success,
          navigate: AuthNavigate.game,
          gameType: GameType.online,
          team: TeamEnum.black));
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
      await _roomRepository.createRoom();
      // await _gameRepository.addStep(
      //   // StepEntity(
      //   //   coordinatiesEntity: CoordinatiesEntity(x: 2, y: 2),
      //   //   x: 32,
      //   //   y: 2,
      //   //   selectedFigure: FigureEntity(
      //   //       id: 2,
      //   //       value: 4,
      //   //       x: 3,
      //   //       y: 3,
      //   //       figureCoordinaties: CoordinatiesEntity(x: 2, y: 2),
      //   //       figurePosition: CoordinatiesEntity(x: 2, y: 2),
      //   //       color: Colors.red,
      //   //       borderColor: Colors.red,
      //   //       team: TeamEnum.white),
      //   // ),
      // );
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
      //TODO: Удаление комнаты при выходе из игры

      await _roomRepository.exitFromRoom();
      await AppDependencies().removeBoardController();
      emit(state.copyWith(
          status: BaseStatus.success, navigate: AuthNavigate.menu));
    } on FirebaseAuthException catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }
}
