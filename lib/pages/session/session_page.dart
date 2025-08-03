import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fokus/components/form/form_base.dart';
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

  String _formatDuration(int sec) {
    Duration d = Duration(seconds: sec);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

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

  Future<void> _handleStartSession() async {
    if (_appCtl.sessionIsRunning.value) return;

    // Start the session
    _appCtl.sessionService.startSession();

    // Create the timer display updating event
    _startDisplayTimer();
  }

  void _handleStopSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    SessionRecord sessionRecord = SessionRecord();
    sessionRecord.sessionStart = _appCtl.sessionStart.value!;
    sessionRecord.sessionEnd = DateTime.now();
    sessionRecord.note = "";

    Get.dialog(
      SessionRecordForm(
        formKey: _saveSessionRecordFormKey,
        submitText: "Save",
        title: "Save session record",
        initialValue: sessionRecord,
        onSubmit: (sessionRecord) async {
          sessionRecord.save();
          _appCtl.sessionService.stopSession();
          Get.back();
        },
      ),
    );
  }

  void _handleCancelSession() {
    if (!_appCtl.sessionIsRunning.value) return;

    // Stop the session
    _appCtl.sessionService.stopSession();

    _stopDisplayTimer();
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

  // @override
  // void didChangeDependencies() {

  //   super.didChangeDependencies();
  // }

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
            Text(_formatDuration(_seconds), style: TextStyle(fontSize: 40)),
            SizedBox(height: 15),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (_appCtl.sessionIsRunning.value)
                    ? [
                        FloatingActionButton.small(
                          onPressed: _handleStopSession,
                          heroTag: 'session-stop',
                          child: Icon(Icons.stop),
                        ),
                        SizedBox(width: 15),
                        FloatingActionButton.small(
                          onPressed: _handleCancelSession,
                          heroTag: 'session-cancel',
                          child: Icon(Icons.close),
                        ),
                      ]
                    : [
                        FloatingActionButton.small(
                          onPressed: _handleStartSession,
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
