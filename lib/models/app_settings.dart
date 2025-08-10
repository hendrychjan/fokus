import 'package:fokus/const.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

part 'app_settings.g.dart';

final db = AppController.to.isarService.db!;

@collection
class AppSettings {
  late Id id = Isar.autoIncrement;

  /// Theme mode (light/dark/system)
  @enumerated
  late ThemeMode themeMode;

  /// Theme seed color (hex string consisting of two-digit components
  /// ALPHA-RED-GREEN-BLUE).
  ///
  /// Dart UI color is then created like so: `Color(appSettings.colorARGB)`
  late int themeSeedColorARGB;

  /// Create a default settings preset and save it
  static AppSettings _createDefault() {
    AppSettings defaultSettings = AppSettings();

    defaultSettings.themeMode = Const.defaults.themeMode;
    defaultSettings.themeSeedColorARGB = Const.defaults.themeSeedColor
        .toARGB32();

    // Intentionally not awaited
    defaultSettings.save();

    return defaultSettings;
  }

  /// Save (create or update) this app settings preset
  Future<void> save() async {
    await db.writeTxn(() async {
      await db.appSettings.put(this);
    });
  }

  /// Get the settings preset for the current user, create and return a default
  /// one if it doesnt exist yet
  static Future<AppSettings> getCurrentUserSettings() async {
    // Currently only single user is supported, so there should by just one
    // instance of settings (with id 0)
    AppSettings settings =
        await db.appSettings.where().findFirst() ?? _createDefault();

    return settings;
  }
}
