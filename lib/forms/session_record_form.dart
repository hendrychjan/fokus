import 'package:flutter/material.dart';
import 'package:fokus/components/date_time_form_field.dart';
import 'package:fokus/components/form_base.dart';
import 'package:fokus/models/session_record.dart';

class SessionRecordForm extends FormBase<SessionRecord> {
  final TextEditingController _sessionStartController = TextEditingController();
  final TextEditingController _sessionEndController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  SessionRecordForm({
    super.key,
    required super.formKey,
    required super.submitText,
    required super.title,
    required super.onSubmit,
    super.initialValue,
    super.formViewType,
    super.onDelete,
  });

  @override
  Widget buildFormFields(BuildContext context) {
    return Column(
      children: [
        DateTimeFormField(
          controller: _sessionStartController,
          decoration: InputDecoration(labelText: "Session start"),
          validator: (value) {
            if (value!.isEmpty) return "Enter a session start";
            return null;
          },
        ),
        DateTimeFormField(
          controller: _sessionEndController,
          decoration: InputDecoration(labelText: "Session end"),
          validator: (value) {
            if (value!.isEmpty) return "Enter a session end";
            return null;
          },
        ),
        TextFormField(
          controller: _noteController,
          decoration: InputDecoration(labelText: "Note"),
        ),
      ],
    );
  }

  @override
  SessionRecord mapFormToObject(SessionRecord? initial) {
    SessionRecord sessionRecord = initial ?? SessionRecord();

    sessionRecord.sessionStart = DateTime.parse(_sessionStartController.text);
    sessionRecord.sessionEnd = DateTime.parse(_sessionEndController.text);
    sessionRecord.note = _noteController.text;

    return sessionRecord;
  }

  @override
  void mapObjectToForm() {
    _sessionStartController.text = initialValue!.sessionStart.toIso8601String();
    _sessionEndController.text = initialValue!.sessionEnd.toIso8601String();
    _noteController.text = initialValue!.note ?? "";
  }
}
