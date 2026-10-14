import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fokus/components/confirm_dialog.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/info_dialog.dart';
import 'package:fokus/const.dart';
import 'package:fokus/database/app_database.dart';
import 'package:fokus/forms/session_record_form.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SessionPage<T> extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final GlobalKey<FormState> _saveSessionRecordFormKey = GlobalKey<FormState>();

  /// A short link to the app controller
  AppController get _appCtl => AppController.to;

  /// Number of seconds passed during an active session
  int _seconds = 0;

  /// A source for the lamp image - changes dynamically based on session state
  String _lampImage = Const.assetMapping.lampOff;

  int get _selectedTagIndex => _appCtl.selectedTagIndex.value;
  Tag get _selectedTag => _appCtl.cachedTags.value[_selectedTagIndex];
  Duration get _selectedTagDurationToday =>
      _appCtl.cachedRecordedDurationsByTag.value[_selectedTag.id] ??
      Duration.zero;

  /// Scheduler for updating the timer display
  late Timer _sessionTimer;

  /// Scheduler for updating goal progress
  late Timer _goalUpdateTimer;

  bool _wakelockIsActive = false;

  /// Enable wakelock if allowed in settings
  void _setupWakelock() {
    if (_appCtl.settingsService.appSetting.wakelockEnabled) {
      WakelockPlus.enable();
      setState(() {
        _wakelockIsActive = true;
      });
    }
  }

  /// Stop state update schedulers
  void _startTimers({int initialSeconds = 0}) {
    setState(() {
      _seconds = initialSeconds;
    });

    // Schedule the session display timer
    _sessionTimer = Timer.periodic(
      const Duration(seconds: 1),
      (t) => setState(() {
        _seconds++;
      }),
    );

    // Schedule the goal progress update timer
    _goalUpdateTimer = Timer.periodic(
      const Duration(minutes: 1),
      (t) => _updateTagGoalProgress(),
    );
  }

  /// Stop state update schedulers
  void _stopTimers() {
    setState(() {
      _seconds = 0;
    });

    _sessionTimer.cancel();
    _goalUpdateTimer.cancel();
  }

  /// Event handler for the "start" button for session
  Future<void> _handleStartSession() async {
    if (_appCtl.sessionIsRunning.value) return;

    // Start the session
    _appCtl.sessionService.startSession();

    // Set the lamp mode to "on"
    setState(() {
      _lampImage = Const.assetMapping.lampOn;
    });

    // Start update timers
    _startTimers();

    // Enable wakelock if enabled in settings
    _setupWakelock();
  }

  /// Event handler for the "stop" button for session
  void _handleStopSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    final sessionRecord = SessionRecord(
      id: 0,
      sessionStart: _appCtl.sessionStart.value!,
      sessionEnd: DateTime.now(),
      note: "",
    );

    Get.to(
      () => SessionRecordForm(
        config: FormConfig(
          formKey: _saveSessionRecordFormKey,
          submitText: "Save",
          title: "Save session record",
          initialValue: (record: sessionRecord, tags: []),
          onSubmit: (sessionRecord) async {
            await _appCtl.sessionRecordRepository.save(
              sessionRecord.record,
              tags: sessionRecord.tags,
            );
            await _appCtl.sessionService.stopSession();
            _stopTimers();

            // Set the lamp mode to "on"
            setState(() {
              _lampImage = Const.assetMapping.lampOff;
            });

            // Disable wakelock because session is no longer active
            WakelockPlus.disable();
            setState(() {
              _wakelockIsActive = false;
            });

            Get.back();
          },
        ),
      ),
    );
  }

  /// Event handler for the "cancel" button for session
  void _handleCancelSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    Get.dialog(
      ConfirmDialog(
        titleText: "Cancel session",
        description: "Are you sure you want to discard this session record?",
        confirmText: "Discard",
        cancelText: "Back",
        onConfirm: () {
          // Stop the session
          _appCtl.sessionService.stopSession();
          _stopTimers();

          // Set the lamp mode to "off"
          setState(() {
            _lampImage = Const.assetMapping.lampOff;
          });

          // Disable wakelock because session is no longer active
          WakelockPlus.disable();
          setState(() {
            _wakelockIsActive = false;
          });

          Get.back();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  /// Updates progress values of progress indicators of goals
  Future<void> _updateTagGoalProgress() async {
    // TODO: Implement update goal hook
    // double currentSessionMinutes = _seconds / 60;

    // // Compute progress values for each goal on the session page
    // for (var goalProgress in _goals) {
    //   // Check if the goal's tag is active
    //   if (_activeTags[goalProgress.tag]!) {
    //     // If active, the current session value is added to it's progress
    //     setState(() {
    //       goalProgress.progress =
    //           (goalProgress.minutesBeforeCurrentSession +
    //               currentSessionMinutes) /
    //           goalProgress.goal.targetMinutes;
    //     });
    //   } else {
    //     // If not active, the progress is the one computed without the current
    //     // session
    //     setState(() {
    //       goalProgress.progress =
    //           goalProgress.minutesBeforeCurrentSession /
    //           goalProgress.goal.targetMinutes;
    //     });
    //   }
    // }
  }

  /// Show explanation dialog about the wakelock function
  void _showWakelockDialog() {
    final infoText = (_appCtl.settingsService.appSetting.wakelockEnabled)
        ? "The wakelock feature is currently enabled. Fokus will keep the display from shutting off during session. You can change this in settings."
        : "The wakelock feature is currently disabled. Your display may shut off. You can prevent this by enabling wakelock in settings.";

    Get.dialog(
      InfoDialog(
        titleText: "Wakelock",
        description: infoText,
        onConfirm: Get.back,
      ),
    );
  }

  Widget _buildLampSection() {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Image.asset(_lampImage, fit: BoxFit.contain),
    );
  }

  Widget _buildProgressSection() {
    return Obx(() {
      if (_appCtl.cachedTags.value.isEmpty) {
        return Text("Create tags to track daily goals.");
      }

      final double progress = (_selectedTag.goal != null)
          ? ((_selectedTagDurationToday.inMinutes.toDouble() +
                    (_seconds / 60)) /
                _selectedTag.goal!.toDouble())
          : 1;
      final String progressText = (_selectedTag.goal != null)
          ? "${_selectedTag.goal! - (_selectedTagDurationToday.inMinutes + (_seconds / 60).floor())} minutes left"
          : "No goal set.";

      return Center(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;

            if (velocity < -200) {
              // left
              _appCtl.selectedTagIndex.value++;
            } else if (velocity > 200) {
              // right
              _appCtl.selectedTagIndex.value--;
            }
          },
          child: Row(
            children: [
              Visibility(
                visible: _selectedTagIndex > 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                  onPressed: () => _appCtl.selectedTagIndex.value--,
                  icon: Icon(Icons.arrow_left),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      _appCtl.cachedTags.value[_selectedTagIndex].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    LinearProgressIndicator(value: progress),
                    Text(
                      progressText,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible:
                    _selectedTagIndex < (_appCtl.cachedTags.value.length - 1),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                  onPressed: () => _appCtl.selectedTagIndex.value++,
                  icon: Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTimerSection() {
    return Column(
      children: [
        Text(
          AppController.formatDurationAsStopwatchFromSec(_seconds),
          style: TextStyle(fontSize: 50),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (_appCtl.sessionIsRunning.value)
                ? [
                    FloatingActionButton.small(
                      key: UniqueKey(),
                      onPressed: _handleStopSession,
                      heroTag: 'session-stop',
                      child: Icon(Icons.stop),
                    ),
                    SizedBox(width: 16),
                    FloatingActionButton.small(
                      key: UniqueKey(),
                      onPressed: _handleCancelSession,
                      heroTag: 'session-cancel',
                      child: Icon(Icons.close),
                    ),
                  ]
                : [
                    FloatingActionButton.small(
                      key: UniqueKey(),
                      onPressed: _handleStartSession,
                      heroTag: 'session-start',
                      child: Icon(Icons.play_arrow),
                    ),
                  ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // If there is a session running, restore it
    if (!_appCtl.sessionIsRunning.value) return;

    Duration durationRestored = DateTime.now().difference(
      _appCtl.sessionStart.value!,
    );

    // Set the lamp mode to "on"
    _lampImage = Const.assetMapping.lampOn;

    _startTimers(initialSeconds: durationRestored.inSeconds);

    _setupWakelock();

    super.initState();
  }

  @override
  void dispose() {
    if (_appCtl.sessionIsRunning.value) _sessionTimer.cancel();

    // Always disable wakeclock when leaving session page
    WakelockPlus.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session"),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: _showWakelockDialog,
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: _wakelockIsActive
                  ? Color(Const.assetMapping.lampColor)
                  : Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildLampSection()),
            _buildTimerSection(),
            SizedBox(height: 20),
            _buildProgressSection(),
          ],
        ),
      ),
    );
  }
}
