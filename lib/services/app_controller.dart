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

  /// Format a duration represented a `sec` seconds as a stopwatch resembling string
  static String formatDurationAsStopwatchFromSec(int sec) {
    Duration d = Duration(seconds: sec);
    return formatDurationAsStopwatch(d);
  }

  /// Format a duration as a stopwatch resembling string
  static String formatDurationAsStopwatch(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
