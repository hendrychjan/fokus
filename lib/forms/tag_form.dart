import 'package:flutter/material.dart';
import 'package:fokus/components/form/color_form_field.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/form/section_title_form_field.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class TagForm extends StatefulWidget {
  /// Form configuration
  final FormConfig<Tag> config;

  const TagForm({super.key, required this.config});

  @override
  State<TagForm> createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  // Form field controllers
  final _titleController = TextEditingController();
  final _colorController = TextEditingController();
  final _goalController = TextEditingController();

  /// Map the initial value to form fields
  Future<void> _mapObjectToForm() async {
    _titleController.text = widget.config.initialValue!.title;
    _colorController.text = widget.config.initialValue!.colorARGB.toRadixString(
      16,
    );
    _goalController.text = (widget.config.initialValue!.goal != null)
        ? widget.config.initialValue!.goal.toString()
        : "";
  }

  /// Map the form field values to the result object
  Tag _mapFormToObject(Tag? initial) {
    final title = _titleController.text;
    final colorArgb = int.parse(_colorController.text, radix: 16);
    final goal = int.tryParse(_goalController.text);

    return initial?.copyWith(
          title: title,
          colorARGB: colorArgb,
          goal: drift.Value<int?>(goal),
        ) ??
        Tag(id: 0, title: title, colorARGB: colorArgb, goal: goal);
  }

  /// Build the actual form content
  Widget _buildFormFields() {
    return Column(
      children: [
        // Basic information section
        SectionTitleFormField(title: "Basic information"),
        SpacerFormField(),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: "Title",
            prefixIcon: Icon(Icons.edit),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Enter a title";
            return null;
          },
        ),
        SpacerFormField(),
        ColorFormField(
          controller: _colorController,
          decoration: InputDecoration(
            labelText: "Color",
            prefixIcon: Icon(Icons.color_lens),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) return "Select a color";
            return null;
          },
        ),
        SpacerFormField(),
        TextFormField(
          controller: _goalController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Optional daily goal in minutes",
            prefixIcon: Icon(Icons.timer),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBase<Tag>(
      config: widget.config,
      objectToFormMapper: _mapObjectToForm,
      formToObjectMapper: _mapFormToObject,
      formFieldsBuilder: _buildFormFields,
    );
  }
}
