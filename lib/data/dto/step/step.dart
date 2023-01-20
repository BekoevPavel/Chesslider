import 'package:flutter_chesslider_beta0/data/dto/coordinates/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../figure/figure.dart';

part 'step.g.dart';

part 'step.freezed.dart';

@unfreezed
class Step with _$Step {
  @JsonSerializable(explicitToJson: true)
  factory Step({
    required final int x,
    required final int y,
    bool? canKill,
    required Coordinates coordinates,
    required Figure figure,
  }) = _Step;

  factory Step.fromJson(Map<String, Object?> json) => _$StepFromJson(json);
}
