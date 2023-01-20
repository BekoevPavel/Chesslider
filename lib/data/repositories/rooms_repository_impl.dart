import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/repositories/rooms_repository.dart';
import 'package:otp/otp.dart';
import '../dto/player/player.dart';
import '../dto/room/room.dart';

class RoomsRepositoryImpl extends RoomRepository {
  @override
  Future<Room> connectToRoom(String code) async {
    final room = await FirebaseFirestore.instance
        .collection('rooms')
        .where('id', isEqualTo: code)
        .get();

    print('room: ${room.docs.first.data()}');

    final rumResult = Room.fromJson(room.docs.first.data());

    final Player myUser = AppDependencies().getMyPlayer();

    late String enemyID;
    late String stepsID;

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(room.docs.first.id)
        .update({
      'players': [rumResult.players.first.toJson(), myUser.toJson()]
    });

    return rumResult.copyWith(players: [rumResult.players.first, myUser]);
  }

  @override
  Future<void> createRoom() async {
    final credential = FirebaseAuth.instance.currentUser!;
    final Player myUser = AppDependencies().getMyPlayer();
    final room = Room(
        id: credential.uid,
        players: [myUser],
        firebaseID: '',
        stepsID: '',
        stepsPosition: []);

    await FirebaseFirestore.instance
        .collection('rooms')
        .add(room.toJson())
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
      print('firebaseID: ${roomDoc.id}');
      roomDoc.update({'firebaseID': roomDoc.id});
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
  Stream<Player?> listenOtherPlayerState() async* {
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
          (i.data()!['players'] as List<dynamic>).length > 1) {
        print('есть новое подключение ');

        final remoteRoom = Room.fromJson(i.data()!);

        final Player enemy = remoteRoom.players
            .where((player) =>
                player.userID != AppDependencies().getMyPlayer().userID)
            .toList()
            .first;

        yield enemy;
        //currentRoom.players.add(PlayerEntity(userID: userID, email: email, username: username, winsCount: winsCount, lossCount: lossCount, drawCount: drawCount, gameSearch: gameSearch, networkStatus: networkStatus, rating: rating))
      }
      if (i.data() == null) {
        print('room deleted');

        yield null;
      }
    }
  }

  @override
  Future<Player> getOtherPlayerEntity(String id) async {
    print('find other');
    final userInfo =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    print('Other Player: ${userInfo.data()}');
    return Player.fromJson(userInfo.data()!);
  }
}
