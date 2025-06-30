import 'package:flutter/material.dart';
import 'package:fokus/components/delete_dialog.dart';
import 'package:fokus/models/record.dart';
import 'package:get/get.dart';

class RecordForm extends StatelessWidget {
  /// Form control field
  final GlobalKey<FormState> formKey;

  /// Text to display on the submit button (usually "create" or "save")
  final String submitText;

  /// Title for the form (usually something like "Create a tag")
  final String title;

  /// Handler function for when the form is submitted
  final Future<void> Function(Record record) onSubmit;

  /// Optional initial value (when updating an existing object)
  final Record? initialValue;

  /// Handler function for when a delete event is fired and confirmed by user.
  ///
  /// If supplied, the "delete" button in appbar is shown
  final Future<void> Function(Record record)? onDelete;

  // Internal fields
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  RecordForm({
    super.key,
    required this.formKey,
    required this.submitText,
    required this.title,
    required this.onSubmit,
    this.initialValue,
    this.onDelete,
  }) {
    _loadInitial();
  }

  /// If the initial value is supplied, map its values to form fields
  void _loadInitial() {
    if (initialValue == null) return;

    _noteController.text = initialValue!.note ?? "";
    _startController.text = initialValue!.start.toIso8601String();
    _endController.text = initialValue!.end.toIso8601String();
  }

  /// Validate fields and fire the provided submit handler
  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    // Create or update record
    final record = initialValue ?? Record();

    // Update the values
    record.note = _noteController.text;
    record.start = DateTime.parse(_startController.text);
    record.end = DateTime.parse(_endController.text);

    // Submit with the new version
    await onSubmit(record);
  }

  /// Show a delete confirmation dialog and fire the provided delete handler
  void _handleDelete() {
    Get.dialog(
      DeleteDialog<Record>(
        titleText: "Delete record?",
        contentText: "Record will be permanently deleted.",
        onDelete: onDelete!,
        deleteTarget: initialValue!,
      ),
    );
  }

  /// Show a date-time picker and update the controller with the selected value
  Future<void> _pickDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) return;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime == null) return;

    final combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    controller.text = combinedDateTime.toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          TextButton(onPressed: _handleSubmit, child: Text(submitText)),
          if (initialValue != null)
            TextButton(
              onPressed: _handleDelete,
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Note
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: "Note"),
              ),
              // Start
              TextFormField(
                controller: _startController,
                decoration: InputDecoration(labelText: "Start"),
                readOnly: true,
                onTap: () => _pickDateTime(context, _startController),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Start time is required";
                  if (DateTime.tryParse(value) == null)
                    return "Invalid date format";
                  return null;
                },
              ),
              // End
              TextFormField(
                controller: _endController,
                decoration: InputDecoration(labelText: "End"),
                readOnly: true,
                onTap: () => _pickDateTime(context, _endController),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "End time is required";
                  if (DateTime.tryParse(value) == null)
                    return "Invalid date format";
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
