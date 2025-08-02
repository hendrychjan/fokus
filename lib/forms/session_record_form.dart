import 'package:flutter/material.dart';
import 'package:fokus/components/form/date_time_form_field.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/components/form/multiselect_form_field.dart';
import 'package:fokus/models/session_record.dart';
import 'package:fokus/models/tag.dart';

class SessionRecordForm extends FormBase<SessionRecord> {
  final TextEditingController _sessionStartController = TextEditingController();
  final TextEditingController _sessionEndController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<Tag> _tagsController = [];

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
          decoration: InputDecoration(
            labelText: "Session start",
            prefixIcon: Icon(Icons.play_arrow),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Enter a session start";
            return null;
          },
        ),
        SpacerFormField(),
        DateTimeFormField(
          controller: _sessionEndController,
          decoration: InputDecoration(
            labelText: "Session end",
            prefixIcon: Icon(Icons.pause),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Enter a session end";
            return null;
          },
        ),
        SpacerFormField(),
        TextFormField(
          controller: _noteController,
          decoration: InputDecoration(
            labelText: "Note",
            prefixIcon: Icon(Icons.description),
            border: OutlineInputBorder(),
          ),
        ),
        SpacerFormField(),
        MultiselectFormField<Tag>(
          options: Tag.getAllSync(),
          initialValue: _tagsController,
          itemTitleBuilder: (Tag t) => t.title,
          decoration: InputDecoration(
            labelText: "Tags",
            prefixIcon: Icon(Icons.sell),
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onSaved: (selectedTags) {
            if (selectedTags == null) return;

            _tagsController.clear();
            _tagsController.addAll(selectedTags);
          },
        ),
      ],
    );
  }

  @override
  SessionRecord mapFormToObject(SessionRecord? initial) {
    SessionRecord sessionRecord = initial ?? SessionRecord();

    sessionRecord.loadSync();

    sessionRecord.sessionStart = DateTime.parse(_sessionStartController.text);
    sessionRecord.sessionEnd = DateTime.parse(_sessionEndController.text);
    sessionRecord.note = _noteController.text;
    sessionRecord.tags.clear();
    sessionRecord.tags.addAll(_tagsController);

    return sessionRecord;
  }

  @override
  void mapObjectToForm() {
    _sessionStartController.text = initialValue!.sessionStart.toIso8601String();
    _sessionEndController.text = initialValue!.sessionEnd.toIso8601String();
    _noteController.text = initialValue!.note ?? "";
    _tagsController.addAll(initialValue!.tags);
  }
}
