import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coordinates.freezed.dart';

part 'coordinates.g.dart';

@unfreezed
class Coordinates with _$Coordinates {
  factory Coordinates({
    required double x,
    required double y,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, Object?> json) =>
      _$CoordinatesFromJson(json);
}
