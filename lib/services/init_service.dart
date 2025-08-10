import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class InitService {
  /// Initialize all services - this needs to be run and finished before
  /// the application begins being used
  static Future<void> initApp() async {
    // Initialize GetX controllers
    _initControllers();

    // Initialize database engines
    await Future.wait([_initIsar(), _initStorage()]);

    // Attempt to restore previous sessions
    AppController.to.settingsService.loadAndApplySettings();
    await AppController.to.sessionService.restoreSession();
  }

  /// Run all getx state management init tasks
  static void _initControllers() {
    Get.put(AppController());
  }

  /// Run all Isar database related init tasks
  static Future<void> _initIsar() async {
    await AppController.to.isarService.initialize();
  }

  /// Run all GetStorage database related init tasks
  static Future<void> _initStorage() async {
    await AppController.to.storageService.initialize();
  }
}
