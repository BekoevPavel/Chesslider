import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/lib/core.dart';

abstract class AuthRepository {
  Future<void> singIn(
      {required String email, required String password});

  Future<void> singUp(
      {required String email,
      required String userName,
      required String password});

  Future<void> singOut();

  Stream<bool> checkAuthState();



// Future<void> addPost(
//     {required String descriptoin,
//     List<String>? imagesUrl,
//     List<TagModel>? tags,
//     required Timestamp timestamp});
// Stream<PostEntity> getPost(DateTime dateTime);
//
// Future<void> removePost(PostEntity postEntity);
//
// Stream<List<PostEntity>> getAllPost();
//
// //Stream<List<MessageEntity>> getMessage();
//
// Future<void> editPost(
//     {required String descriptoin,
//     List<String>? imagesUrl,
//     List<TagEntity>? tags,
//     required Timestamp timestamp,
//     required String postID});
}
