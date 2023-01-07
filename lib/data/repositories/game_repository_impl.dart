import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/domain/entities/figure_coordinates_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/room_entity.dart';
import 'package:flutter_chesslider_beta0/domain/entities/step_entity.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/game_repository.dart';
import 'package:get_it/get_it.dart';

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

  @override
  Future<void> createRoom() async {
    final credential = FirebaseAuth.instance.currentUser!;
    final PlayerEntity myUser = GetIt.instance.get<List<PlayerEntity>>().first;
    final room =
        RoomEntity(id: credential.uid, players: [myUser], stepsPositions: []);

    await FirebaseFirestore.instance
        .collection('rooms')
        .add(room.toFirebase())
        .then((value) {
      value.update({'id': value.id});
      room.id = value.id;
    });

    GetIt.instance.get<List<RoomEntity>>().clear();
    GetIt.instance.get<List<RoomEntity>>().addAll([room]);
    print(
        'create new room: ${GetIt.instance.get<List<RoomEntity>>().first.id}');
  }

  @override
  Future<void> addStep(step) async {
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
    RoomEntity room = GetIt.instance.get<List<RoomEntity>>().first;

    await rooms
        .doc(room.id)
        .update({
          'stepsPositions': [step.toFirebase()]
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    // TODO: implement addStep
    //throw UnimplementedError();
  }

  @override
  Stream<StepEntity> getLastStep() async* {
    var ff = FirebaseFirestore.instance.collection('rooms').where('id',
        isEqualTo: GetIt.instance.get<List<RoomEntity>>().first.id);

    await for (var t in ff.snapshots()) {
      for (var g in t.docs) {
        if (g.data()['stepsPositions'].toString() != '[]') {
          yield StepEntity.fromFirebase(g.data());
        }
      }
    }
  }

  @override
  Future<RoomEntity> connectToRoom(String code) async {
    final room =
        await FirebaseFirestore.instance.collection('rooms').doc(code).get();

    final PlayerEntity myUser = GetIt.instance.get<List<PlayerEntity>>().first;

    late String enemyID;

    enemyID = room.data()?['playersID'][0];
    await FirebaseFirestore.instance.collection('rooms').doc(code).update({
      'playersID': [enemyID, myUser.userID]
    });

    final data =
        await FirebaseFirestore.instance.collection('users').doc(enemyID).get();
    final enterData = data.data();
    PlayerEntity player = PlayerEntity.fromFirebase(enterData!);

    return RoomEntity(id: code, players: [myUser, player], stepsPositions: []);
  }

  @override
  Future<void> exitFromRoom() async {
    final localRoom = GetIt.instance.get<List<RoomEntity>>().first;

    print('delete room: ${localRoom.id}');
    //final room
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(localRoom.id)
        .delete();

    //FirebaseFirestore.instance.collection('rooms').doc(room.id).update({'playersID': []});
  }
}
