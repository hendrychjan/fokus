import 'package:flutter/material.dart';
import 'package:fokus/models/tag.dart';
import 'package:get/get.dart';

/// Form page for creating/editing a tag
class TagForm extends StatelessWidget {
  /// Form control field
  final GlobalKey<FormState> formKey;

  /// Text to display on the submit button (usually "create" or "save")
  final String submitText;

  /// Title for the form (usually something like "Create a tag")
  final String title;

  /// Handler function for when the form is submitted
  final Future<void> Function(Tag tag) onSubmit;

  /// Optional initial value (when updating an existing object)
  final Tag? initialValue;

  /// Handler function for when a delete event is fired and confirmed by user.
  ///
  /// If supplied, the "delete" button in appbar is shown
  final Future<void> Function(Tag tag)? onDelete;

  // Internal fields
  final TextEditingController _nameController = TextEditingController();

  TagForm({
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

    _nameController.text = initialValue!.name;
  }

  /// Validate fields and fire the provided submit handler
  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    // Create or update Tag
    final tag = initialValue ?? Tag();

    // Update the values
    tag.name = _nameController.text;

    // Submit with the new version
    await onSubmit(tag);
  }

  /// Show a delete confirmation dialog and fire the provided delete handler
  void _handleDelete() {
    Get.dialog(
      AlertDialog(
        title: Text("Delete tag?"),
        content: Text("Tag ${initialValue!.name} will be permanently deleted."),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await onDelete!(initialValue!);
              Get.back();
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value!.isEmpty) return "Enter a name";
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
