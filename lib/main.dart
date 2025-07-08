import 'package:flutter/material.dart';
import 'package:fokus/pages/init_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Fokus",
      home: const InitPage(),
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
    ),
  );
}
