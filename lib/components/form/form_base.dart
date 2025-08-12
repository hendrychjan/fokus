import 'package:flutter/material.dart';
import 'package:fokus/components/delete_dialog.dart';
import 'package:get/get.dart';

enum FormViewType { fullscreen, dialog }

class FormConfig<T> {
  /// Form control field
  final GlobalKey<FormState> formKey;

  /// Title for the form (usually something like "Create a tag")
  final String title;

  /// Text to display on the submit button (usually "create" or "save")
  final String submitText;

  /// A flag whether the form is fullscreen (wrapped in scaffold) or in a dialog
  final FormViewType viewType;

  /// Optional initial value (when updating an existing object)
  final T? initialValue;

  /// Handler function for when the form is submitted
  final Future<void> Function(T) onSubmit;

  /// Handler function for when a delete event is fired and confirmed by user.
  ///
  /// If supplied, the "delete" button in appbar is shown
  final Future<void> Function(T)? onDelete;

  FormConfig({
    required this.formKey,
    required this.title,
    required this.submitText,
    this.viewType = FormViewType.fullscreen,
    this.initialValue,
    required this.onSubmit,
    this.onDelete,
  });
}

class FormBase<T> extends StatefulWidget {
  /// Form configuration - appearance and actions
  final FormConfig<T> config;

  /// Map the object to form fields
  final void Function() objectToFormMapper;

  /// Map the form field values to the object
  final T Function(T? initial) formToObjectMapper;

  /// A builder for the actual content of the form
  final Widget Function() formFieldsBuilder;

  const FormBase({
    super.key,
    required this.config,
    required this.objectToFormMapper,
    required this.formToObjectMapper,
    required this.formFieldsBuilder,
  });

  @override
  State<FormBase<T>> createState() => _FormBaseState<T>();
}

class _FormBaseState<T> extends State<FormBase<T>> {
  /// Validate fields and fire the provided submit handler
  void _handleSubmit() async {
    if (!widget.config.formKey.currentState!.validate()) return;

    widget.config.formKey.currentState?.save();

    // Update the values
    T object = widget.formToObjectMapper(widget.config.initialValue);

    // Submit with the new version
    await widget.config.onSubmit(object);
  }

  /// Show a delete confirmation dialog and fire the provided delete handler
  void _handleDelete() {
    if (widget.config.initialValue == null) return;

    Get.dialog(
      DeleteDialog<T>(
        titleText: "Delete?",
        contentText: "The item will be permanently deleted.",
        onDelete: widget.config.onDelete!,
        deleteTarget: widget.config.initialValue as T,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Use the child provided function for value mapping of provided initial
    /// object to the form fields
    if (widget.config.initialValue == null) return;

    widget.objectToFormMapper();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config.viewType == FormViewType.fullscreen) {
      // === Fulscreen variant ===
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.config.title),
          actions: [
            TextButton(
              onPressed: _handleSubmit,
              child: Text(widget.config.submitText),
            ),
            if (widget.config.initialValue != null &&
                widget.config.onDelete != null)
              TextButton(
                onPressed: _handleDelete,
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: widget.config.formKey,
            child: widget.formFieldsBuilder(),
          ),
        ),
      );
    } else {
      // === Dialog variant ===
      return AlertDialog(
        title: Text(widget.config.title),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: widget.config.formKey,
            child: widget.formFieldsBuilder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: _handleSubmit,
            child: Text(widget.config.submitText),
          ),
        ],
      );
    }
  }
}
