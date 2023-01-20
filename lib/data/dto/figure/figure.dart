import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chesslider_beta0/data/dto/coordinates/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/enums/team_enum.dart';

part 'figure.g.dart';

part 'figure.freezed.dart';

@unfreezed
class Figure with _$Figure {
  @JsonSerializable(
      explicitToJson: true) // чтобы внутренние классы тоже переводились в json;
  factory Figure({
    required final int id,
    required final int value,
    required int x,
    required int y,
    required Coordinates coordinates,
    required final TeamEnum team,
    required final int points,
    @Default(0) @JsonKey(ignore: true) int countSteps,
    @Default(false) @JsonKey(ignore: true) bool reachedTheEnd,
    //TODO: Пользовательская сериализация
    // @Default(false)
    // @JsonKey(toJson: toNull, includeIfNull: false)
  }) = _Figure;

  factory Figure.fromJson(Map<String, Object?> json) => _$FigureFromJson(json);

  static toNull(_) => null;
}

// String _getColor(Color color)
// {
//   //return color.value
// }

// int id;
// int value;
// int x;
// int y;
// TeamEnum team;
// CoordinatiesEntity figureCoordinaties;
// CoordinatiesEntity figurePosition;
// int countSteps = 0;
// Color color;
// Color borderColor;
// bool reachedTheEnd = false;
// int weight;
