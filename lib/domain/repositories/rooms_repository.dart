import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';

import '../entities/room_entity.dart';

abstract class RoomRepository {
  Future<RoomEntity> connectToRoom(String code);

  Future<void> exitFromRoom();

  Future<void> createRoom();

  Stream<String?> listenOtherPlayerState();

  Future<PlayerEntity> getOtherPlayerEntity(String id);
}
