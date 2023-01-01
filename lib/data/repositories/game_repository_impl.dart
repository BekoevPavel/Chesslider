import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';

import '../../domain/entities/player_entity.dart';

class GameRepositoryImpl extends GameRepository {
  @override
  Future<void> userOff() async {
    var fire = FirebaseFirestore.instance
        .collection('users')
        .where('gameSearch', isEqualTo: 'on');

    await for (var players in fire.snapshots()) {
      if (players.docs.isNotEmpty) {
        for (var p in players.docs) {
          PlayerEntity.fromFirebase(p.data());
        }
      }
    }
  }

  @override
  Future<void> foundOnlinePlayers() async {
    var fire = FirebaseFirestore.instance
        .collection('users')
        .where('gameSearch', isEqualTo: 'on');

    await for (var players in fire.snapshots()) {
      if (players.docs.isNotEmpty) {
        print('lenght: ${players.docs.length}');
        for (var p in players.docs) {
          print('p: ${p.data()}');
          PlayerEntity.fromFirebase(p.data());
        }
      }
    }
  }
}
