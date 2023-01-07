import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';

import '../entities/step_entity.dart';

abstract class GameRepository {
  Future<void> userOff();

  Future<void> foundOnlinePlayers();

  Future<void> createRoom();

  Future<void> addStep(StepEntity step);

  Stream<StepEntity> getLastStep();

  Future<RoomEntity> connectToRoom(String code);

  Future<void> exitFromRoom();
}
