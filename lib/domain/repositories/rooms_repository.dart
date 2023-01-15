import '../entities/room_entity.dart';

abstract class RoomRepository {
  Future<RoomEntity> connectToRoom(String code);

  Future<void> exitFromRoom();

  Future<void> createRoom();

  Stream<RoomEntity> listenRoomState();
}
