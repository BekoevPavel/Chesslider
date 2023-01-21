import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/enums/game_search.dart';
import '../../../domain/enums/network_status.dart';

part 'player.g.dart';

part 'player.freezed.dart';

@unfreezed // свойства могут быть не final
class Player with _$Player {
  @JsonSerializable(explicitToJson: true)
  factory Player({
    @JsonKey(name: 'userID1') required final String userID,
    required final String email,
    required final String username,
    required int winsCount,
    required int lossCount,
    required int drawCount,
    required NetworkStatus networkStatus,
    required GameSearch gameSearch,
    required double rating,
  }) = _Player;

  factory Player.fromJson(Map<String, Object?> json) => _$PlayerFromJson(json);
}
