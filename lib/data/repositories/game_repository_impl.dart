import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/network_status.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:flutter_chesslider_beta0/presentation/game/states/board_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:otp/otp.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/enums/game_search.dart';
import '../../domain/enums/team_enum.dart';

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

  @override
  Future<void> addStep(step) async {
    //CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    CollectionReference steps = FirebaseFirestore.instance.collection('steps');
    RoomEntity room = AppDependencies().getRoom();

    // await rooms
    //     .doc(room.firebaseID)
    //     .update({
    //       'stepsPositions': [step.toFirebase()]
    //     })
    //     .then((value) => print("User Updated"))
    //     .catchError((error) => print("Failed to update user: $error"));
    await steps
        .doc(room.stepsID)
        .update({'stepsPositions': step.toFirebase()})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    // TODO: implement addStep
    //throw UnimplementedError();
  }

  @override
  Stream<StepEntity> getLastStep() async* {
    // BoardController _boardController = GetIt.instance.get<BoardController>();
    // TeamEnum whoMove = _boardController.refery.whoseMove;
    // final bool listenState = _boardController.myTeam == whoMove ? false : true;

    var ff = FirebaseFirestore.instance
        .collection('steps')
        .where('roomID', isEqualTo: AppDependencies().getRoom().firebaseID);

    await for (var t in ff.snapshots()) {
      for (var g in t.docs) {
        if (g.data()['stepsPositions'].toString() != 'null') {
          yield StepEntity.fromFirebase(g.data());
        }
      }
    }
  }

  @override
  Future<void> updatePlayerInfo(PlayerEntity player) async {
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
