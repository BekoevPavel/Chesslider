import 'package:flutter_chesslider_beta0/domain/entities/figure_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';

import 'figure_coordinates_entity.dart';

class RoomEntity {
  String id;
  String firebaseID;
  List<PlayerEntity> players;
  List<FigureEntity> stepsPositions;
  String stepsID;

  RoomEntity({
    required this.id,
    required this.players,
    required this.stepsPositions,
    required this.firebaseID,
    required this.stepsID,
  });

  Map<String, dynamic> toFirebase() {
    // print('player1: ${players.map((e) => e.userID).toList()}');
    return {
      'id': id,
      'playersID': players.map((e) => e.userID).toList(),
      'stepsPositions': stepsPositions
          .map(
            (e) => {'x': '${e.x}', 'y': '${e.y}', 'f': '${e.team.name}'},
          )
          .toList()
    };
  }
}
