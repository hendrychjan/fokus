import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fokus/components/confirm_dialog.dart';
import 'package:fokus/forms/session_record_form.dart';
import 'package:fokus/models/session_record.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class SessionPage<T> extends StatefulWidget {
  const SessionPage({super.key});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final GlobalKey<FormState> _saveSessionRecordFormKey = GlobalKey<FormState>();
  final _appCtl = AppController.to;
  int _seconds = 0;
  late Timer _sessionTimer;

  void _startDisplayTimer({int initialSeconds = 0}) {
    setState(() {
      _seconds = initialSeconds;
    });
    _sessionTimer = Timer.periodic(
      const Duration(seconds: 1),
      (t) => setState(() {
        _seconds++;
      }),
    );
  }

  void _stopDisplayTimer() {
    setState(() {
      _seconds = 0;
    });
    _sessionTimer.cancel();
  }

  Future<void> _onStartSession() async {
    if (_appCtl.sessionIsRunning.value) return;

    // Start the session
    _appCtl.sessionService.startSession();

    // Create the timer display updating event
    _startDisplayTimer();
  }

  void _onStopSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    SessionRecord sessionRecord = SessionRecord();
    sessionRecord.sessionStart = _appCtl.sessionStart.value!;
    sessionRecord.sessionEnd = DateTime.now();
    sessionRecord.note = "";

    Get.to(
      () => SessionRecordForm(
        formKey: _saveSessionRecordFormKey,
        submitText: "Save",
        title: "Save session record",
        initialValue: sessionRecord,
        onSubmit: (sessionRecord) async {
          sessionRecord.save();
          _appCtl.sessionService.stopSession();
          _stopDisplayTimer();
          Get.back();
        },
      ),
    );
  }

  void _onCancelSession() {
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
          _stopDisplayTimer();
          Get.back();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  @override
  void initState() {
    if (!_appCtl.sessionIsRunning.value) return;

    Duration durationRestored = DateTime.now().difference(
      _appCtl.sessionStart.value!,
    );

    _startDisplayTimer(initialSeconds: durationRestored.inSeconds);

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
      appBar: AppBar(title: Text("Session"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppController.formatDurationAsStopwatchFromSec(_seconds),
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 15),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (_appCtl.sessionIsRunning.value)
                    ? [
                        FloatingActionButton.small(
                          onPressed: _onStopSession,
                          heroTag: 'session-stop',
                          child: Icon(Icons.stop),
                        ),
                        SizedBox(width: 15),
                        FloatingActionButton.small(
                          onPressed: _onCancelSession,
                          heroTag: 'session-cancel',
                          child: Icon(Icons.close),
                        ),
                      ]
                    : [
                        FloatingActionButton.small(
                          onPressed: _onStartSession,
                          heroTag: 'session-start',
                          child: Icon(Icons.play_arrow),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
