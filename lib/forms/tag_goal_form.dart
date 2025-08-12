import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/form/multiselect_form_field.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/const.dart';
import 'package:fokus/models/tag.dart';
import 'package:flutter/material.dart';

class TagGoalForm extends StatelessWidget {
  /// Form configuration
  final FormConfig<TagGoal> config;

  TagGoalForm({super.key, required this.config});

  // Form field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _targetMinutesController =
      TextEditingController();
  final List<int> _weekdaysController = [];

  /// Maps the initialValue to form fields
  void _mapObjectToForm() {
    _titleController.text = config.initialValue!.title;
    _targetMinutesController.text = config.initialValue!.targetMinutes
        .toString();

    _weekdaysController.clear();
    _weekdaysController.addAll(config.initialValue!.weekdays);
  }

  /// Maps the form field values to a result object
  TagGoal _mapFormToObject(TagGoal? initial) {
    TagGoal tagGoal = initial ?? TagGoal();

    tagGoal.title = _titleController.text;
    tagGoal.targetMinutes = int.parse(_targetMinutesController.text);

    // Reset weekdays, then set only those selected in the form
    tagGoal.weekdays = _weekdaysController;

    return tagGoal;
  }

  /// Defines the actual content of the form
  Widget _buildFormFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // === Title ===
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: "Title",
            prefixIcon: Icon(Icons.edit),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Enter the goal's title";
            return null;
          },
        ),
        SpacerFormField(),

        // === Target minutes ===
        TextFormField(
          controller: _targetMinutesController,
          decoration: InputDecoration(
            labelText: "Target minutes",
            prefixIcon: Icon(Icons.timer),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Enter the goal's target in minutes";
            if (int.tryParse(value) == null) {
              return "Invalid format. Only a whole number is accepted.";
            }
            return null;
          },
          keyboardType: TextInputType.numberWithOptions(),
        ),
        SpacerFormField(),

        // === Target weekdays ===
        MultiselectFormField<Weekday>(
          options: Const.defaults.weekdays,
          itemTitleBuilder: (Weekday obj) => obj.label,
          onSaved: (selectedWeekdays) {
            if (selectedWeekdays == null) return;

            _weekdaysController.clear();
            _weekdaysController.addAll(selectedWeekdays.map((w) => w.number));
          },
          initialValue: _weekdaysController
              .map((w) => Const.defaults.weekdays[w - 1])
              .toList(),
          decoration: InputDecoration(
            labelText: "Target weekdays",
            prefixIcon: Icon(Icons.calendar_month),
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBase<TagGoal>(
      config: config,
      objectToFormMapper: _mapObjectToForm,
      formToObjectMapper: _mapFormToObject,
      formFieldsBuilder: _buildFormFields,
    );
  }
}
