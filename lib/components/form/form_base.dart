import 'package:flutter/material.dart';
import 'package:fokus/components/delete_dialog.dart';
import 'package:get/get.dart';

enum FormViewType { fullscreen, dialog }

abstract class FormBase<T> extends StatefulWidget {
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

  const FormBase({
    super.key,
    required this.formKey,
    required this.submitText,
    required this.title,
    required this.onSubmit,
    this.initialValue,
    this.onDelete,
    this.formViewType = FormViewType.fullscreen,
  });

  @override
  State<FormBase<T>> createState() => _FormBaseState<T>();

  /// Map the object to form fields
  void mapObjectToForm();

  /// Map the form field values to the object
  T mapFormToObject(T? initial);

  Widget buildFormFields(BuildContext context);
}

class _FormBaseState<T> extends State<FormBase<T>> {
  /// Validate fields and fire the provided submit handler
  void _handleSubmit() async {
    if (!widget.formKey.currentState!.validate()) return;

    widget.formKey.currentState?.save();

    // Update the values
    T object = widget.mapFormToObject(widget.initialValue);

    // Submit with the new version
    await widget.onSubmit(object);
  }

  /// Show a delete confirmation dialog and fire the provided delete handler
  void _handleDelete() {
    if (widget.initialValue == null) return;

    Get.dialog(
      DeleteDialog<T>(
        titleText: "Delete?",
        contentText: "The item will be permanently deleted.",
        onDelete: widget.onDelete!,
        deleteTarget: widget.initialValue as T,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Use the child provided function for value mapping of provided initial
    /// object to the form fields
    if (widget.initialValue == null) return;

    widget.mapObjectToForm();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.formViewType == FormViewType.fullscreen) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            TextButton(
              onPressed: _handleSubmit,
              child: Text(widget.submitText),
            ),
            if (widget.initialValue != null && widget.onDelete != null)
              TextButton(
                onPressed: _handleDelete,
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: widget.formKey,
            child: widget.buildFormFields(context),
          ),
        ),
      );
    } else {
      return widget.buildFormFields(context);
    }
  }
}
