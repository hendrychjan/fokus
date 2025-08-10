import 'package:flutter/material.dart';

class Const {
  // Private constructor to disallow instantiation
  Const._();

  static const storageKeys = _StorageKeys();
  static const defaults = _Defaults();
}

class _StorageKeys {
  const _StorageKeys();

  // Box keys
  final String boxSession = "SessionBox";

  // Value keys - session
  final String keySessionIsRunning = "sessionIsRunning";
  final String keySessionStart = "sessionStart";
}

class _Defaults {
  const _Defaults();

  // Session related
  final bool sessionIsRunning = false;
  final DateTime? sessionStart = null;

  // Theme related
  final Color themeSeedColor = Colors.blue;
  final ThemeMode themeMode = ThemeMode.system;
}
