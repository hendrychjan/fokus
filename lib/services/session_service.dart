import 'package:fokus/const.dart';
import 'package:fokus/services/app_controller.dart';

class SessionService {
  /// Shortcuts to AppController properties
  AppController get _appCtl => AppController.to;

  /// Save session related values from AppController to local storage
  void _saveSessionState() async {
    await Future.wait([
      _appCtl.storageService.sessionBox.write(
        Const.storageKeys.keySessionIsRunning,
        _appCtl.sessionIsRunning.value.toString(),
      ),
      _appCtl.storageService.sessionBox.write(
        Const.storageKeys.keySessionStart,
        _appCtl.sessionStart.value.toString(),
      ),
    ]);
  }

  /// Begin recording a session
  Future<void> startSession() async {
    if (_appCtl.sessionIsRunning.value) {
      throw "Start session event called but session is already running.";
    }

    _appCtl.sessionIsRunning.value = true;
    _appCtl.sessionStart.value = DateTime.now();

    _saveSessionState();
  }

  /// Stop recording a session
  Future<void> stopSession() async {
    if (!_appCtl.sessionIsRunning.value) {
      throw "Stop session event called but a session is not running.";
    }

    _appCtl.sessionIsRunning.value = false;
    _appCtl.sessionStart.value = null;

    _saveSessionState();
  }

  /// Attempt to restore a previously started session
  Future<void> restoreSession() async {
    String? storedValueSessionIsRunning = _appCtl.storageService.sessionBox
        .read(Const.storageKeys.keySessionIsRunning);

    String? storedValueSessionStart = _appCtl.storageService.sessionBox.read(
      Const.storageKeys.keySessionStart,
    );

    // Restore the session running indicator
    _appCtl.sessionIsRunning.value =
        bool.tryParse(storedValueSessionIsRunning ?? "") ?? false;

    if (!_appCtl.sessionIsRunning.value) return;

    // Session is running, restore the time it started
    _appCtl.sessionStart.value = DateTime.tryParse(
      storedValueSessionStart ?? "",
    );

    if (_appCtl.sessionStart.value == null) {
      throw "Unable to resture a running session.";
    }
  }
}
