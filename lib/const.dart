import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

  // Application directory
  Future<Directory> get applicationDirectory async {
    final dir = await getApplicationDocumentsDirectory();
    final fokusPath = Directory('${dir.path}/fokus');
    if (!await fokusPath.exists()) {
      await fokusPath.create(recursive: true);
    }
    return fokusPath;
  }

  final List<Weekday> weekdays = const [
    Weekday(number: 1, label: 'Mon'),
    Weekday(number: 2, label: 'Tue'),
    Weekday(number: 3, label: 'Wed'),
    Weekday(number: 4, label: 'Thu'),
    Weekday(number: 5, label: 'Fri'),
    Weekday(number: 6, label: 'Sat'),
    Weekday(number: 7, label: 'Sun'),
  ];
}

class Weekday {
  const Weekday({required this.number, required this.label});

  final int number;
  final String label;
}
