abstract class AuthEvent {}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});
}

class AuthSignOut extends AuthEvent {}

/// Регистрация
class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String username;

  AuthSignUp(
      {required this.email, required this.password, required this.username});
}
