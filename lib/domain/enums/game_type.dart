import 'package:freezed_annotation/freezed_annotation.dart';

enum GameType {
  @JsonValue('online')
  online,
  @JsonValue('offline')
  offline
}
