import 'package:fokus/const.dart';
import 'package:fokus/services/app_controller.dart';

class SessionService {
  /// Save session related values from AppController to local storage
  void _saveSessionState() async {
    await Future.wait([
      AppController.to.storageService.sessionBox.write(
        Const.storageKeys.keySessionIsRunning,
        AppController.to.sessionIsRunning.value.toString(),
      ),
      AppController.to.storageService.sessionBox.write(
        Const.storageKeys.keySessionStart,
        AppController.to.sessionStart.value.toString(),
      ),
    ]);
  }

  /// Begin recording a session
  Future<void> startSession() async {
    if (AppController.to.sessionIsRunning.value) {
      throw "Start session event called but session is already running.";
    }

    AppController.to.sessionIsRunning.value = true;
    AppController.to.sessionStart.value = DateTime.now();

    _saveSessionState();
  }

  /// Stop recording a session
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
        .read(Const.storageKeys.keySessionIsRunning);

    String? storedValueSessionStart = AppController.to.storageService.sessionBox
        .read(Const.storageKeys.keySessionStart);

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
