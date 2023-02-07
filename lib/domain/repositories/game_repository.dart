import '../../data/dto/player/player.dart';
import '../../data/dto/step/step.dart' as s;

abstract class GameRepository {
  Future<void> userOff();

  Future<void> foundOnlinePlayers();

  Future<void> addStep(s.Step step);

  Stream<s.Step> getLastStep();

  Future<void> updatePlayerInfo(Player player);
}
