import 'package:fokus/services/isar_service.dart';
import 'package:fokus/services/session_service.dart';
import 'package:fokus/services/storage_service.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  /// Global shortcut to app controller singleton
  static AppController get to => Get.find<AppController>();

  /// Isar (primary nosql database) database service
  IsarService isarService = IsarService();

  /// GetStorage (key-value database) database service
  StorageService storageService = StorageService();

  /// Session storage for centralized session control
  SessionService sessionService = SessionService();

  Rx<bool> sessionIsRunning = Rx<bool>(false);
  Rx<DateTime?> sessionStart = Rx<DateTime?>(null);
}
