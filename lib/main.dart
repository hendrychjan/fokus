import 'package:flutter/material.dart';
import 'package:fokus/pages/init_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Fokus",
      home: const InitPage(),
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    ),
  );
}
