import 'package:hive/hive.dart';

@HiveType(typeId: 8)
enum SettingsThemeMode {
  @HiveField(0)
  dark,
  @HiveField(1)
  light,
  @HiveField(2)
  system,
}
