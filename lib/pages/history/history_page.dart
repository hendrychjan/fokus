import 'package:flutter/material.dart';
import 'package:fokus/forms/session_record_form.dart';
import 'package:fokus/models/session_record.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final GlobalKey<FormState> createSessionRecordFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> updateSessionRecordFormKey =
      GlobalKey<FormState>();

  /// Create/update a session record in the database
  Future<void> _handleSaveSessionRecord(SessionRecord sessionRecord) async {
    await sessionRecord.save();
    Get.back();
  }

  /// Delete a session record from the database
  Future<void> _handleDeleteSessionRecord(SessionRecord sessionRecord) async {
    await sessionRecord.delete();
    Get.back();
  }

  /// Open a dialog for creating a new session record
  void _openCreateDialog() {
    Get.to(
      () => SessionRecordForm(
        formKey: createSessionRecordFormKey,
        title: "Create a session record",
        submitText: "Create",
        onSubmit: _handleSaveSessionRecord,
      ),
      fullscreenDialog: true,
    );
  }

  /// Open a dialog for editing session records
  void _openEditDialog(SessionRecord sessionRecord) {
    Get.to(
      () => SessionRecordForm(
        formKey: updateSessionRecordFormKey,
        submitText: "Update",
        title: "Update a record",
        initialValue: sessionRecord,
        onSubmit: _handleSaveSessionRecord,
        onDelete: _handleDeleteSessionRecord,
      ),
    );
  }

  /// Create a list view item from a session record
  Widget _sessionRecordItemBuilder(
    BuildContext context,
    int index,
    List<SessionRecord> sessionRecords,
  ) {
    bool isDifferentDay(DateTime a, DateTime b) =>
        a.year != b.year || a.month != b.month || a.day != b.day;

    String formatDateDivider(DateTime d) {
      if (isDifferentDay(DateTime.now(), d)) {
        return "${d.day}. ${d.month}. ${d.year}";
      } else {
        return "Today";
      }
    }

    final sessionRecord = sessionRecords[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((index == 0) ||
            (isDifferentDay(
              sessionRecords[index - 1].sessionStart,
              sessionRecord.sessionStart,
            ))) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              formatDateDivider(sessionRecord.sessionStart),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        GestureDetector(
          onTap: () => _openEditDialog(sessionRecord),
          child: ListTile(
            title: Text(
              AppController.formatDurationAsStopwatch(
                sessionRecord.sessionEnd.difference(sessionRecord.sessionStart),
              ),
            ),
            trailing: Icon(Icons.arrow_right),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<SessionRecord>>(
        stream: SessionRecord.getAllStream().map(
          (list) => list.reversed.toList(),
        ),
        builder: (context, snapshot) {
          // Check the stream state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recorded sessions yet'));
          }

          // Create list items from stream's items
          final sessionRecords = snapshot.data!;
          return ListView.builder(
            itemCount: sessionRecords.length,
            itemBuilder: (context, index) =>
                _sessionRecordItemBuilder(context, index, sessionRecords),
          );
        },
      ),
    );
  }
}
