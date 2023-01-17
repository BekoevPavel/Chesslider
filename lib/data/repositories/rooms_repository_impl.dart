import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
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

    final PlayerEntity myUser = AppDependencies().getMyPlayer();

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
    final PlayerEntity myUser = AppDependencies().getMyPlayer();
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

    AppDependencies().setRoom(room);
    print('create new room: ${AppDependencies().getRoom().id}');
  }

  @override
  Future<void> exitFromRoom() async {
    final localRoom = AppDependencies().getRoom();

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
  Stream<String?> listenOtherPlayerState() async* {
    print('listenRoom');
    // TODO: implement listenRoomState
    final currentRoom = AppDependencies().getRoom();
    final wated = FirebaseFirestore.instance
        .collection('rooms')
        .doc(currentRoom.firebaseID)
        .snapshots();
    await for (var i in wated) {
      print('roomInfo: ${i.data()}');
      if (i.data() != null &&
          i.data()?['stepsID'] != null &&
          i.data()!['playersID'].toString().length > 46) {
        print('есть новое подключение ');
        final lst = i.data()?['playersID'] as List<dynamic>;
        final otherID = lst
            .where((element) {
              if (element.toString() !=
                  FirebaseAuth.instance.currentUser!.uid) {
                return true;
              }
              return false;
            })
            .toList()
            .first
            .toString();
        print('otherID: ${otherID}');
        yield otherID;
        //currentRoom.players.add(PlayerEntity(userID: userID, email: email, username: username, winsCount: winsCount, lossCount: lossCount, drawCount: drawCount, gameSearch: gameSearch, networkStatus: networkStatus, rating: rating))
      }
      if (i.data() == null) {
        print('room deleted');

        yield null;
      }
    }
  }

  @override
  Future<PlayerEntity> getOtherPlayerEntity(String id) async {
    print('find other');
    final userInfo =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    print('Other Player: ${userInfo.data()}');
    return PlayerEntity.fromFirebase(userInfo.data()!);
  }
}
