import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fokus/const.dart';
import 'package:fokus/pages/init_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Fokus",
      home: const InitPage(),
      theme: ThemeData(
        colorSchemeSeed: Const.defaults.themeSeedColor,
        brightness: PlatformDispatcher.instance.platformBrightness,
        useMaterial3: true,
      ),
      // darkTheme: ThemeData(
      //   colorSchemeSeed: Const.defaults.themeSeedColor,
      //   brightness: Brightness.dark,
      //   useMaterial3: true,
      // ),
      // themeMode: Const.defaults.themeMode,
      themeMode: ThemeMode.light,
    ),
  );
}
