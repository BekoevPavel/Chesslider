import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TeamEnum {
  @JsonValue('white')
  white,
  @JsonValue('black')
  black
}
