import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/lib/core.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AuthFailure?> singIn(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('saccess');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var doc = await users.doc(credential.user?.uid).get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      //---
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .update({'data': 'mydata'});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthFailure.userNotFound;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return AuthFailure.wrongPassword;
      }
    }
  }

  @override
  Future<AuthFailure?> singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<AuthFailure?> singUp(
      {required String email,
      required String userName,
      required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'userID': credential.user!.uid,
        'email': credential.user!.email,
        'username': userName,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return AuthFailure.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return AuthFailure.emailAlreadyInUse;
      }
    } catch (e) {
      print('reeriir $e');
    }
  }
}
