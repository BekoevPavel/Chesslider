import 'package:flutter_chesslider_beta0/domain/enums/game_search.dart';
import 'package:flutter_chesslider_beta0/domain/enums/network_status.dart';

class PlayerEntity {
  final String userID;
  final String email;
  final String username;
  int winsCount;
  int lossCount;
  int drawCount;
  NetworkStatus networkStatus;
  GameSearch gameSearch;
  double rating;

  PlayerEntity(
      {required this.userID,
      required this.email,
      required this.username,
      required this.winsCount,
      required this.lossCount,
      required this.drawCount,
      required this.gameSearch,
      required this.networkStatus,
      required this.rating});

  factory PlayerEntity.fromFirebase(Map<String, dynamic> data) {
    GameSearch gameSearch;
    NetworkStatus networkStatus;

    if (data['gameSearch'] == 'on') {
      gameSearch = GameSearch.on;
    } else {
      gameSearch = GameSearch.off;
    }

    if (data['networkStatus'] == 'online') {
      networkStatus = NetworkStatus.online;
    } else {
      networkStatus = NetworkStatus.offline;
    }
    return PlayerEntity(
        userID: data['userID1'],
        email: data['email'],
        username: data['username'],
        winsCount: data['winsCount'],
        lossCount: data['lossCount'],
        drawCount: data['drawsCount'],
        gameSearch: gameSearch,
        networkStatus: networkStatus,
        rating: data['rating']);
  }
}
