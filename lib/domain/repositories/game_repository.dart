import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';

import '../entities/step_entity.dart';

abstract class GameRepository {
  Future<void> userOff();

  Future<void> foundOnlinePlayers();

  Future<void> addStep(StepEntity step);

  Stream<StepEntity> getLastStep();

  Future<void> updatePlayerInfo(PlayerEntity player);
}
