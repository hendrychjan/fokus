import 'package:flutter/material.dart';
import 'package:fokus/getx/app_controller.dart';
import 'package:fokus/pages/root_page.dart';
import 'package:get/get.dart';

void main() {
  Get.put(AppController());

  runApp(const GetMaterialApp(title: "Fokus", home: RootPage()));
}
