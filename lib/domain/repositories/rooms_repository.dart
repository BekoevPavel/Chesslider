import '../../data/dto/player/player.dart';
import '../../data/dto/room/room.dart';

abstract class RoomRepository {
  Future<Room> connectToRoom(String code);

  Future<void> exitFromRoom();

  Future<void> createRoom();

  Stream<Player?> listenOtherPlayerState();

  Future<Player> getOtherPlayerEntity(String id);
}
