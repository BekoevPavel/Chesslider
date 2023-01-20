import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum GameSearch {
  @JsonValue('off')
  off,
  @JsonValue('on')
  on
}

extension GameSearchExtension on GameSearch {
  String get toFirebase => describeEnum(this);
}
