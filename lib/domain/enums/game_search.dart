import 'package:flutter/foundation.dart';

enum GameSearch { off , on }

extension GameSearchExtension on GameSearch {
  String get toFirebase => describeEnum(this);


}
