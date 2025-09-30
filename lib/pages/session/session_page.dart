import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fokus/components/confirm_dialog.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/const.dart';
import 'package:fokus/forms/session_record_form.dart';
import 'package:fokus/models/session_record.dart';
import 'package:fokus/models/tag.dart';
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

  /// List of active tags (their goals will be updated as time on the timer
  /// increases)
  final Map<Tag, bool> _activeTags = {};

  /// Scheduler for updating the timer display
  late Timer _sessionTimer;

  /// Scheduler for updating goal progress
  late Timer _goalUpdateTimer;

  bool _wakelockEnabled = false;

  /// Switch on/off the display wakelock
  void _switchWakelock() {
    WakelockPlus.toggle(enable: !_wakelockEnabled);

    setState(() {
      _wakelockEnabled = !_wakelockEnabled;
    });
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
  }

  /// Event handler for the "stop" button for session
  void _handleStopSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    SessionRecord sessionRecord = SessionRecord();
    sessionRecord.sessionStart = _appCtl.sessionStart.value!;
    sessionRecord.sessionEnd = DateTime.now();
    sessionRecord.note = "";

    Get.to(
      () => SessionRecordForm(
        config: FormConfig(
          formKey: _saveSessionRecordFormKey,
          submitText: "Save",
          title: "Save session record",
          initialValue: sessionRecord,
          onSubmit: (sessionRecord) async {
            sessionRecord.save();
            _appCtl.sessionService.stopSession();
            _stopTimers();

            // Set the lamp mode to "on"
            setState(() {
              _lampImage = Const.assetMapping.lampOff;
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

          // Set the lamp mode to "on"
          setState(() {
            _lampImage = Const.assetMapping.lampOff;
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

  Widget _buildLampSection() {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Image.asset(_lampImage, fit: BoxFit.contain),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: LinearProgressIndicator(value: 2 / 5),
        ),
        Text("2/5 goals completed today"),
      ],
    );
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
    if (!_appCtl.sessionIsRunning.value) return;

    Duration durationRestored = DateTime.now().difference(
      _appCtl.sessionStart.value!,
    );

    // Set the lamp mode to "on"
    _lampImage = Const.assetMapping.lampOn;

    _startTimers(initialSeconds: durationRestored.inSeconds);

    super.initState();
  }

  @override
  void dispose() {
    if (AppController.to.sessionIsRunning.value) _sessionTimer.cancel();
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
            onPressed: _switchWakelock,
            icon: Icon(
              _wakelockEnabled ? Icons.lightbulb : Icons.lightbulb_outline,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLampSection(),
            _buildTimerSection(),
            // _buildProgressSection(),
          ],
        ),
      ),
    );
  }
}
