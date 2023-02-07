import 'package:freezed_annotation/freezed_annotation.dart';
import '../figure/figure.dart';
import '../player/player.dart';

part 'room.g.dart';

part 'room.freezed.dart';

@unfreezed
class Room with _$Room {
  @JsonSerializable(explicitToJson: true)
  factory Room({
    required String id,
    required  String firebaseID,
    required final List<Player> players,
    required List<Figure> stepsPosition,
    required String stepsID,
  }) = _Room;

  factory Room.fromJson(Map<String, Object?> json) => _$RoomFromJson(json);
}
