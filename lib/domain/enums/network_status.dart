import 'package:flutter/foundation.dart';

enum NetworkStatus { online, offline }


extension NetworkStatusExtension on NetworkStatus{
  String get toFirebase => describeEnum(this);
}