import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/rooms_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:otp/otp.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/entities/room_entity.dart';

class RoomsRepositoryImpl extends RoomRepository {
  @override
  Future<RoomEntity> connectToRoom(String code) async {
    // final room =
    //     await FirebaseFirestore.instance.collection('rooms').doc('').get();

    final room = await FirebaseFirestore.instance
        .collection('rooms')
        .where('id', isEqualTo: code)
        .get();

    final PlayerEntity myUser = GetIt.instance.get<List<PlayerEntity>>().first;

    late String enemyID;
    late String stepsID;
    print('roomData: ${room.docs.first.data()} , ${room.docs.first.id}');

    enemyID = room.docs.first.data()?['playersID'][0];
    stepsID = room.docs.first.data()?['stepsID'];

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(room.docs.first.id)
        .update({
      'playersID': [enemyID, myUser.userID]
    });

    final data =
        await FirebaseFirestore.instance.collection('users').doc(enemyID).get();
    final enterData = data.data();
    PlayerEntity player = PlayerEntity.fromFirebase(enterData!);

    return RoomEntity(
        id: code,
        players: [myUser, player],
        stepsPositions: [],
        firebaseID: room.docs.first.id,
        stepsID: stepsID);
  }

  @override
  Future<void> createRoom() async {
    final credential = FirebaseAuth.instance.currentUser!;
    final PlayerEntity myUser = GetIt.instance.get<List<PlayerEntity>>().first;
    final room = RoomEntity(
        id: credential.uid,
        players: [myUser],
        stepsPositions: [],
        firebaseID: '',
        stepsID: '');

    await FirebaseFirestore.instance
        .collection('rooms')
        .add(room.toFirebase())
        .then((roomDoc) async {
      var result = OTP.generateTOTPCodeString(
          roomDoc.id, DateTime.now().millisecondsSinceEpoch,
          algorithm: Algorithm.SHA1, length: 6);
      print('room ID: ${result}');
      roomDoc.update({'id': result});
      await FirebaseFirestore.instance
          .collection('steps')
          .add({'roomID': roomDoc.id}).then((stepsDoc) {
        room.stepsID = stepsDoc.id;
        roomDoc.update({'stepsID': stepsDoc.id});
      });

      room.id = result.toString();
      room.firebaseID = roomDoc.id;
    });

    print('roomID: ${room.firebaseID}');

    GetIt.instance.get<List<RoomEntity>>().clear();
    GetIt.instance.get<List<RoomEntity>>().addAll([room]);
    print(
        'create new room: ${GetIt.instance.get<List<RoomEntity>>().first.id}');
  }

  @override
  Future<void> exitFromRoom() async {
    final localRoom = GetIt.instance.get<List<RoomEntity>>().first;

    print('delete room: ${localRoom.id}');
    //final room
    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(localRoom.firebaseID)
        .delete();
    await FirebaseFirestore.instance
        .collection('steps')
        .doc(localRoom.stepsID)
        .delete();

    //FirebaseFirestore.instance.collection('rooms').doc(room.id).update({'playersID': []});
  }

  @override
  Stream<RoomEntity> listenRoomState() async* {
    print('listenRoom');
    // TODO: implement listenRoomState
    final currentRoom = GetIt.instance.get<List<RoomEntity>>().first;
    final wated = FirebaseFirestore.instance
        .collection('rooms')
        .doc(currentRoom.firebaseID)
        .snapshots();
    await for (var i in wated) {
      print('roomInfo: ${i.data()}');
    }

    throw UnimplementedError();
  }
}
