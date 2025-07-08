import 'package:flutter/material.dart';
import 'package:fokus/components/form_base.dart';
import 'package:fokus/models/category.dart';

class CategoryForm extends FormBase<Category> {
  final TextEditingController _titleController = TextEditingController();

  CategoryForm({
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
  Category mapFormToObject(Category? initial) {
    Category category = initial ?? Category();

    category.title = _titleController.text;

    return category;
  }

  @override
  void mapObjectToForm() {
    _titleController.text = initialValue!.title;
  }

  @override
  Widget buildFormFields(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(labelText: "Title"),
        ),
      ],
    );
  }
}
