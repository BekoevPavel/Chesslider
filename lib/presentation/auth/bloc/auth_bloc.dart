import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
import 'package:flutter_chesslider_beta0/presentation/auth/bloc/auth_event.dart';

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

  FutureOr<void> _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        status: BaseStatus.loading, navigate: AuthNavigate.registration));
    try {
      await _authRepository.singUp(
          email: event.email,
          userName: event.username,
          password: event.password);
      emit(state.copyWith(
          navigate: AuthNavigate.menu, status: BaseStatus.success));
    } on FirebaseAuthException catch (error, stackTrace) {
      handleError(error, stackTrace, emit);
    }
  }

  FutureOr<void> _signIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        status: BaseStatus.loading, navigate: AuthNavigate.localAuth));
    try {
      await _authRepository.singIn(
          email: event.email, password: event.password);
      emit(state.copyWith(
          navigate: AuthNavigate.menu, status: BaseStatus.success));
    } on FirebaseAuthException catch (error, stackTrace) {
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
