import 'package:fokus/const.dart';
import 'package:fokus/database/app_database.dart';

class AppSettingsRepository {
  final AppDatabase _db;

  AppSettingsRepository(this._db);

  /// Save (create or update) an app settings preset
  Future<void> save(AppSetting appSetting) async {
    await _db.into(_db.appSettings).insertOnConflictUpdate(appSetting);
  }

  /// Get the settings preset for the current user, create and return a default
  /// one if it doesnt exist yet
  Future<AppSetting> getCurrentUserSettings() async {
    // Currently only single user is supported, so there should by just one
    // instance of settings (with id 0)
    AppSetting? setting = await (_db.select(
      _db.appSettings,
    )..where((x) => x.id.equals(1))).getSingleOrNull();

    if (setting != null) return setting;

    // Create new default settings
    await _db
        .into(_db.appSettings)
        .insert(
          AppSettingsCompanion.insert(
            themeMode: Const.defaults.themeMode,
            themeSeedColorARGB: Const.defaults.themeSeedColor.toARGB32(),
            wakelockEnabled: Const.defaults.wakelockEnabled,
          ),
        );

    // Currently only single user is supported, so there should by just one
    // instance of settings (with id 1)
    setting = await (_db.select(
      _db.appSettings,
    )..where((x) => x.id.equals(1))).getSingleOrNull();

    if (setting != null) return setting;

    throw Exception("Failed to create and save default settings.");
  }
}
