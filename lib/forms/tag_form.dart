import 'package:flutter/material.dart';
import 'package:fokus/components/color_form_field.dart';
import 'package:fokus/components/form_base.dart';
import 'package:fokus/models/tag.dart';

class TagForm extends FormBase<Tag> {
  TagForm({
    super.key,
    required super.formKey,
    required super.submitText,
    required super.title,
    required super.onSubmit,
    super.initialValue,
    super.formViewType,
    super.onDelete,
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  @override
  Tag mapFormToObject(Tag? initial) {
    Tag tag = initial ?? Tag();

    tag.title = _titleController.text;
    tag.colorARGB = int.parse(_colorController.text, radix: 16);

    return tag;
  }

  @override
  void mapObjectToForm() {
    _titleController.text = initialValue!.title;
    _colorController.text = initialValue!.colorARGB.toString();
  }

  @override
  Widget buildFormFields(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(labelText: "Title"),
          validator: (value) {
            if (value!.isEmpty) return "Enter a title";
            return null;
          },
        ),

        ColorFormField(
          controller: _colorController,
          decoration: InputDecoration(labelText: "Color"),
          validator: (value) {
            if (value!.isEmpty) return "Select a color";
            return null;
          },
        ),
      ],
    );
  }
}
