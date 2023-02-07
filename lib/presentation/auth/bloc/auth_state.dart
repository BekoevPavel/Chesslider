import 'package:equatable/equatable.dart';
import 'package:flutter_chesslider_beta0/core/lib/base_bloc/base_bloc.dart';
// part of 'auth_bloc.dart';

class AuthState extends BaseState {
  final AuthNavigate? navigate;

  AuthState({super.status = BaseStatus.initial, this.navigate});

  @override
  AuthState copyWith(
      {BaseStatus? status, String? email, AuthNavigate? navigate}) {
    // TODO: implement copyWith
    return AuthState(
        status: status ?? BaseStatus.initial,

        navigate: navigate ?? this.navigate);
  }
}

enum AuthNavigate {splash, localAuth, registration, menu, game }

// abstract class AuthState extends  BaseState {
//   AuthState({required super.status});
// }
//
// class AuthInitial extends AuthState {
//   AuthInitial({required super.status});
//
//   @override
//   BaseState copyWith({required BaseStatus status, BaseError baseError}) {
//     // TODO: implement copyWith
//     throw UnimplementedError();
//   }
//
// }
//
// class AuthLoading extends AuthState {
//
// }
//
// class AuthSignUp extends AuthState {
//
// }
//
// class AuthSignIn extends AuthState {
//
// }
//
// class AuthFailure extends AuthState {
//   final String message;
//
//   AuthFailure({required this.message});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [message];
// }
