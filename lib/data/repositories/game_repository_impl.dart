import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/core/lib/isolates/base_parse.dart';
import 'package:flutter_chesslider_beta0/domain/enums/network_status.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import '../../domain/enums/game_search.dart';
import '../dto/player/player.dart';
import '../dto/room/room.dart';
import '../dto/step/step.dart' as s;

class GameRepositoryImpl extends GameRepository {
  @override
  Future<void> userOff() async {
    var fire = FirebaseFirestore.instance
        .collection('users')
        .where('gameSearch', isEqualTo: 'on');

    await for (var players in fire.snapshots()) {
      if (players.docs.isNotEmpty) {
        for (var p in players.docs) {
          Player.fromJson(p.data());
        }
      }
    }
  }

  @override
  Future<void> foundOnlinePlayers() async {
    var fire = FirebaseFirestore.instance
        .collection('users')
        ..where('gameSearch', isEqualTo: 'on');

    await for (var players in fire.snapshots()) {
      if (players.docs.isNotEmpty) {
        print('lenght: ${players.docs.length}');
        for (var p in players.docs) {
          print('p: ${p.data()}');
          Player.fromJson(p.data());
        }
      }
    }
  }

  @override
  Future<void> addStep(step) async {
    CollectionReference steps = FirebaseFirestore.instance.collection('steps');
    Room room = AppDependencies().getRoom();

    await steps
        .doc(room.stepsID)
        .update({'stepsPositions': step.toJson()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Stream<s.Step> getLastStep() async* {
    print('getLastStep');
    var ff = FirebaseFirestore.instance
        .collection('steps')
        .where('roomID', isEqualTo: AppDependencies().getRoom().firebaseID);

    await for (var t in ff.snapshots()) {
      for (var g in t.docs) {
        if (g.data()['stepsPositions'].toString() != 'null') {
          print('yield');
          //final step = s.Step.fromJson(g.data()['stepsPositions']);
          final step = await BaseParse.fromJson(
              s.Step.fromJson, g.data()['stepsPositions']);
          if (step.figure.team !=
              AppDependencies().getBoardController().myTeam) {
            yield await BaseParse.fromJson(
                s.Step.fromJson, g.data()['stepsPositions']);
          }
        }
      }
    }
  }

  @override
  Future<void> updatePlayerInfo(Player player) async {
    FirebaseFirestore.instance.collection('users').doc(player.userID).update({
      'winsCount': player.winsCount,
      'lossCount': player.drawCount,
      'drawsCount': player.lossCount,
      'networkStatus': player.networkStatus.toFirebase,
      'gameSearch': GameSearch.on.toFirebase,
      'rating': player.rating,
    });
  }
}
