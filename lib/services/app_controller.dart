import 'package:fokus/services/isar_service.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  /// Global shortcut to app controller singleton
  static AppController get to => Get.find<AppController>();

  /// Isar (primary database) database service
  IsarService isarService = IsarService();
}
