import '../../auth/bloc/auth_event.dart';

abstract class HomeEvent {}

class HomeSignOut extends HomeEvent {}

class HomeFirstStart extends HomeEvent {}

class HomeCreateRoom extends HomeEvent {
  HomeCreateRoom();
}

class ConnectToRoom extends HomeEvent {
  final String code;

  ConnectToRoom(this.code);
}

class ExitFromRoom extends HomeEvent {}
