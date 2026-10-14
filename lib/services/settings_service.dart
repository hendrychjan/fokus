import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fokus/database/app_database.dart';
import 'package:fokus/repository/app_settings_repository.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class SettingsService {
  late AppSetting appSetting;

  /// Shortcut to app settings repository
  AppSettingsRepository get _appSettingsRepository =>
      AppController.to.appSettingsRepository;

  /// Load settings (or initialize with default) and apply it
  Future<void> loadAndApplySettings() async {
    // Load settings
    appSetting = await _appSettingsRepository.getCurrentUserSettings();

    // Apply theme related settings
    updateAppTheme();
  }

  /// Saves current settings state to memory
  Future<void> saveSettings() async {
    return _appSettingsRepository.save(appSetting);
  }

  /// Update app theme based on current user settings
  void updateAppTheme() {
    // Select brightness based on theme mode
    Brightness brightness = PlatformDispatcher.instance.platformBrightness;
    if (appSetting.themeMode == ThemeMode.light) {
      brightness = Brightness.light;
    } else if (appSetting.themeMode == ThemeMode.dark) {
      brightness = Brightness.dark;
    }

    // Build the new theme
    ThemeData themeData = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(appSetting.themeSeedColorARGB),
        brightness: brightness,
      ),
    );

    // Apply the new theme
    Get.changeTheme(themeData);
  }
}
