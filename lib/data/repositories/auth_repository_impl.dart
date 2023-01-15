import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chesslider_beta0/domain/entities/player_entity.dart';
import 'package:flutter_chesslider_beta0/domain/enums/game_search.dart';
import 'package:flutter_chesslider_beta0/domain/enums/network_status.dart';

import '../../core/lib/core.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> singIn({required String email, required String password}) async {
    print('авторизация');

    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('saccess');
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var doc = await users.doc(credential.user?.uid).get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  }

  @override
  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> singUp(
      {required String email,
      required String userName,
      required String password}) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      'userID1': credential.user!.uid,
      'email': credential.user!.email,
      'username': userName,
      'winsCount': 0,
      'lossCount': 0,
      'drawsCount': 0,
      'networkStatus': NetworkStatus.online.toFirebase,
      'gameSearch': GameSearch.on.toFirebase,
      'rating': 0.0
    });
  }

  @override
  Stream<bool> checkAuthState() async* {
    // TODO: implement checkAuthState
    var stream = FirebaseAuth.instance.authStateChanges();

    await for (var u in stream) {
      if (u != null) {
        yield true;
      }
      yield false;
    }
  }

  @override
  Future<PlayerEntity> getPlayer1() async {
    // TODO: implement getPlayer1
    final myID = FirebaseAuth.instance.currentUser!.uid;
    var fire = FirebaseFirestore.instance
        .collection('users')
        .where('userID1', isEqualTo: myID);

    await for (var players in fire.snapshots()) {
      if (players.docs.isNotEmpty) {
        for (var p in players.docs) {
          print('p: ${p.data()}');
          return PlayerEntity.fromFirebase(p.data());
        }
      }
    }
    throw UnimplementedError();
  }
}
