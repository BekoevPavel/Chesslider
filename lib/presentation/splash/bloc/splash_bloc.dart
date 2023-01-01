import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';

import '../../../core/lib/base_bloc/base_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../auth/bloc/auth_state.dart';

class SplashEvent {}

class SplashState extends BaseState {
  bool? userState = false;
  AuthNavigate? navigate = AuthNavigate.splash;

  SplashState(
      {super.status = BaseStatus.initial, this.navigate, this.userState});

  @override
  SplashState copyWith(
      {BaseStatus? status,
      String? email,
      AuthNavigate? navigate,
      bool? userState}) {
    // TODO: implement copyWith
    return SplashState(
      status: status ?? BaseStatus.initial,
      navigate: navigate ?? this.navigate,
      userState: userState ?? this.userState,
    );
  }
}

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;
  final GameRepository _gameRepository;

  SplashBloc(AuthRepository authRepository, GameRepository gameRepository)
      : _authRepository = authRepository,
        _gameRepository = gameRepository,
        super(SplashState(status: BaseStatus.initial)) {
    on<SplashEvent>((event, emit) async {
      //_authRepository.singOut();
      int count = 0;
      try {
        await for (var userState in _authRepository.checkAuthState()) {
          if (count == 0) {
            emit(state.copyWith(
                status: BaseStatus.success,
                navigate: userState == true
                    ? AuthNavigate.menu
                    : AuthNavigate.localAuth));

            print(
                'ID: ${FirebaseAuth.instance.currentUser!.uid} state: ${userState}');
            count = 1;
          }
        }
      } catch (error, stackTrace) {
        handleError(error, stackTrace, emit);
      }
      print('ID: ${FirebaseAuth.instance.currentUser!.uid}');
     // _gameRepository.foundOnlinePlayers();
    });
  }
}
