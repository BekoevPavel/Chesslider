import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_event.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AuthState(status: BaseStatus.initial)) {
    on<AuthSignUp>(_signUp);
    on<AuthSignIn>(_signIn);
    on<AuthSignOut>(_signOut);
  }

  FutureOr<void> _signUp(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BaseStatus.loading));
    try {
      _authRepository.singUp(
          email: event.email,
          userName: event.userName,
          password: event.password);
      emit(state.copyWith(
          navigate: AuthNavigate.menu, status: BaseStatus.success));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _signIn(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BaseStatus.loading));
    try {
      _authRepository.singIn(email: event.email, password: event.password);
      emit(state.copyWith(
          navigate: AuthNavigate.menu, status: BaseStatus.success));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _signOut(_, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BaseStatus.loading));
    try {
      _authRepository.singOut();
      emit(state.copyWith(
          navigate: AuthNavigate.localAuth, status: BaseStatus.success));
    } catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }
}

//
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//
//   Future<void> signIn({required String email, required String password}) async {
//     emit(AuthLoading());
//     MainRepository mainRepository = MainRepositoryImpl();
//     var res = await mainRepository.singIn(email: email, password: password);
//     if (res != null) {
//       emit(AuthFailure(message: res.toString()));
//       print('error');
//     } else {
//       print('norm');
//       emit(AuthSignIn());
//     }
//   }
//
//   Future<void> signOut() async {
//     MainRepository mainRepository = MainRepositoryImpl();
//     await mainRepository.singOut();
//   }
//
//   Future<void> signUp(
//       {required String email,
//       required String password,
//       required String username}) async {
//     emit(AuthLoading());
//     MainRepository mainRepository = MainRepositoryImpl();
//
//     var res = await mainRepository.singUp(
//         email: email, userName: username, password: password);
//     if (res != null) {
//       emit(AuthFailure(message: res.toString()));
//     } else {
//       emit(AuthSignUp());
//     }
//   }
// }
