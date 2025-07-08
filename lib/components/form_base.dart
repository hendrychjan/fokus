import 'package:flutter/material.dart';
import 'package:fokus/components/delete_dialog.dart';
import 'package:get/get.dart';

enum FormViewType { fullscreen, dialog }

abstract class FormBase<T> extends StatelessWidget {
  /// Form control field
  final GlobalKey<FormState> formKey;

  /// A flag whether the form is fullscreen (wrapped in scaffold) or in a dialog
  final FormViewType formViewType;

  /// Text to display on the submit button (usually "create" or "save")
  final String submitText;

  /// Title for the form (usually something like "Create a tag")
  final String title;

  /// Handler function for when the form is submitted
  final Future<void> Function(T) onSubmit;

  /// Optional initial value (when updating an existing object)
  final T? initialValue;

  /// Handler function for when a delete event is fired and confirmed by user.
  ///
  /// If supplied, the "delete" button in appbar is shown
  final Future<void> Function(T)? onDelete;

  FormBase({
    super.key,
    required this.formKey,
    required this.submitText,
    required this.title,
    required this.onSubmit,
    this.initialValue,
    this.onDelete,
    this.formViewType = FormViewType.fullscreen,
  }) {
    // Here, the `mapExisingData` function isn't called directly because it
    // could happen that the parent/child class isn't fully loaded and thus the
    // call could fail or end with unexpected behavior (race conditions)
    _loadInitial();
  }

  /// Use the child provided function for value mapping of provided initial
  /// object to the form fields
  void _loadInitial() {
    if (initialValue == null) return;

    mapObjectToForm();
  }

  /// Map the object to form fields
  void mapObjectToForm();

  /// Map the form field values to the object
  T mapFormToObject(T? initial);

  /// Validate fields and fire the provided submit handler
  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    // Update the values
    T object = mapFormToObject(initialValue);

    // Submit with the new version
    await onSubmit(object);
  }

  /// Show a delete confirmation dialog and fire the provided delete handler
  void _handleDelete() {
    if (initialValue == null) return;

    Get.dialog(
      DeleteDialog<T>(
        titleText: "Delete?",
        contentText: "The item will be permanently deleted.",
        onDelete: onDelete!,
        deleteTarget: initialValue as T,
      ),
    );
  }

  /// Show a date-time picker and update the controller with the selected value
  Future<void> pickDateTime(
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

  Widget buildFormFields(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (formViewType == FormViewType.fullscreen) {
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
          child: Form(key: formKey, child: buildFormFields(context)),
        ),
      );
    } else {
      return buildFormFields(context);
    }
  }
}
