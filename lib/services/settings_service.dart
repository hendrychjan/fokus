import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fokus/models/app_settings.dart';
import 'package:get/get.dart';

class SettingsService {
  late AppSettings appSettings;

  /// Load settings (or initialize with default) and apply it
  Future<void> loadAndApplySettings() async {
    // Load settings
    appSettings = await AppSettings.getCurrentUserSettings();

    // Apply theme related settings
    updateAppTheme();
  }

  /// Saves current settings state to memory
  Future<void> saveSettings() async {
    return appSettings.save();
  }

  /// Update app theme based on current user settings
  void updateAppTheme() {
    // Select brightness based on theme mode
    Brightness brightness = PlatformDispatcher.instance.platformBrightness;
    if (appSettings.themeMode == ThemeMode.light) {
      brightness = Brightness.light;
    } else if (appSettings.themeMode == ThemeMode.dark) {
      brightness = Brightness.dark;
    }

    // Build the new theme
    ThemeData themeData = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(appSettings.themeSeedColorARGB),
        brightness: brightness,
      ),
    );

    // Apply the new theme
    Get.changeTheme(themeData);
  }
}
