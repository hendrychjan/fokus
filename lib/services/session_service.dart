import 'package:fokus/services/app_controller.dart';

class SessionService {
  void _saveSessionState() async {
    await Future.wait([
      AppController.to.storageService.sessionBox.write(
        "sessionIsRunning",
        AppController.to.sessionIsRunning.value.toString(),
      ),
      AppController.to.storageService.sessionBox.write(
        "sessionStart",
        AppController.to.sessionStart.value.toString(),
      ),
    ]);
  }

  Future<void> startSession() async {
    if (AppController.to.sessionIsRunning.value) {
      throw "Start session event called but session is already running.";
    }

    AppController.to.sessionIsRunning.value = true;
    AppController.to.sessionStart.value = DateTime.now();

    _saveSessionState();
  }

  Future<void> stopSession() async {
    if (!AppController.to.sessionIsRunning.value) {
      throw "Stop session event called but a session is not running.";
    }

    AppController.to.sessionIsRunning.value = false;
    AppController.to.sessionStart.value = null;

    _saveSessionState();
  }

  /// Attempt to restore a previously started session
  Future<void> restoreSession() async {
    String? storedValueSessionIsRunning = AppController
        .to
        .storageService
        .sessionBox
        .read("sessionIsRunning");

    String? storedValueSessionStart = AppController.to.storageService.sessionBox
        .read("sessionStart");

    // Restore the session running indicator
    AppController.to.sessionIsRunning.value =
        bool.tryParse(storedValueSessionIsRunning ?? "") ?? false;

    if (!AppController.to.sessionIsRunning.value) return;

    // Session is running, restore the time it started
    AppController.to.sessionStart.value = DateTime.tryParse(
      storedValueSessionStart ?? "",
    );

    if (AppController.to.sessionStart.value == null) {
      throw "Unable to resture a running session.";
    }
  }
}
