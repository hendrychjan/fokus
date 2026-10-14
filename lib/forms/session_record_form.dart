import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:fokus/components/form/async_multiselect_form_field.dart';
import 'package:fokus/components/form/date_time_form_field.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/database/app_database.dart';
import 'package:fokus/services/app_controller.dart';

typedef SessionRecordFormData = ({SessionRecord record, List<Tag> tags});

class SessionRecordForm extends StatelessWidget {
  /// Form configuration
  final FormConfig<SessionRecordFormData> config;

  SessionRecordForm({super.key, required this.config});

  /// Shortcut to app controller
  AppController get _appCtl => AppController.to;

  // Form field controllers
  final TextEditingController _sessionStartController = TextEditingController();
  final TextEditingController _sessionEndController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<Tag> _tagsController = [];

  /// Maps the initialValue to form fields
  Future<void> _mapObjectToForm() async {
    _sessionStartController.text = config.initialValue!.record.sessionStart
        .toIso8601String();
    _sessionEndController.text = config.initialValue!.record.sessionEnd
        .toIso8601String();
    _noteController.text = config.initialValue!.record.note ?? "";
    _tagsController.addAll(config.initialValue!.tags);
  }

  /// Maps the form field values to a result object
  SessionRecordFormData _mapFormToObject(SessionRecordFormData? initial) {
    final sessionStart = DateTime.parse(_sessionStartController.text);
    final sessionEnd = DateTime.parse(_sessionEndController.text);
    final note = _noteController.text;

    return (
      record:
          initial?.record.copyWith(
            sessionStart: sessionStart,
            sessionEnd: sessionEnd,
            note: drift.Value<String?>(note),
          ) ??
          SessionRecord(
            id: 0,
            sessionStart: sessionStart,
            sessionEnd: sessionEnd,
          ),
      tags: _tagsController,
    );
  }

  /// Defines the actual content of the form
  Widget _buildFormFields() {
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
        AsyncMultiselectFormField<Tag>(
          getOptions: _appCtl.tagRepository.getAll(),
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
  Widget build(BuildContext context) {
    return FormBase<SessionRecordFormData>(
      config: config,
      objectToFormMapper: _mapObjectToForm,
      formToObjectMapper: _mapFormToObject,
      formFieldsBuilder: _buildFormFields,
    );
  }
}
