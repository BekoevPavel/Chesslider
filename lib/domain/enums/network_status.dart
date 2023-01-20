import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum NetworkStatus {
  @JsonValue('online')
  online,
  @JsonValue('online')
  offline
}

extension NetworkStatusExtension on NetworkStatus {
  String get toFirebase => describeEnum(this);
}
