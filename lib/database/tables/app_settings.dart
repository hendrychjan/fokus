import 'package:flutter/material.dart' as material;
import 'package:drift/drift.dart';

typedef AppThemeMode = material.ThemeMode;

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Theme mode (light/dark/system)
  TextColumn get themeMode => textEnum<AppThemeMode>()();

  /// Theme seed color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(appSettings.colorARGB)`
  IntColumn get themeSeedColorARGB => integer()();

  /// Wakelock on session page enabled
  BoolColumn get wakelockEnabled => boolean()();
}
