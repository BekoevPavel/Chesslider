import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../data/dto/room/room.dart';

class BaseParse {
  static Future<T> fromJson<T>(FutureOr<T> Function(Map<String, dynamic>) task,
      Map<String, dynamic> data) async {
    return await compute(task, data);
  }

  static Future<Map<String, dynamic>> toJson(
      FutureOr<Map<String, dynamic>> Function(dynamic) task) async {
    return await compute(task, null);
  }
}
