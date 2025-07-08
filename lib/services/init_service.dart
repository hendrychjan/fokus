import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class InitService {
  /// Initialize all services - this needs to be run and finished before
  /// the application begins being used
  static Future<void> initApp() async {
    _initGetx();
    _initDb();
  }

  /// Run all getx state management init tasks
  static void _initGetx() {
    Get.put(AppController());
  }

  /// Run all database related init tasks
  static Future<void> _initDb() async {
    await AppController.to.isarService.initialize();
  }
}
