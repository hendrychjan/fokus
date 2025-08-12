import 'package:flutter/material.dart';
import 'package:fokus/components/confirm_dialog.dart';
import 'package:fokus/components/form/color_form_field.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/components/form/section_title_form_field.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/const.dart';
import 'package:fokus/forms/tag_goal_form.dart';
import 'package:fokus/models/tag.dart';
import 'package:get/get.dart';

class TagForm extends StatefulWidget {
  /// Form configuration
  final FormConfig<Tag> config;

  const TagForm({super.key, required this.config});

  @override
  State<TagForm> createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  // Sub-form keys
  final GlobalKey<FormState> _createTagGoalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editTagGoalFormKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final List<TagGoal> _goalsController = [];

  /// Opens a dialog for creating a tag goal
  void _handleAddGoal() {
    Get.dialog(
      TagGoalForm(
        config: FormConfig(
          formKey: _createTagGoalFormKey,
          title: "Create a goal",
          submitText: "Create",
          viewType: FormViewType.dialog,
          onSubmit: (TagGoal newGoal) async {
            setState(() {
              _goalsController.add(newGoal);
            });
            Get.back();
          },
        ),
      ),
    );
  }

  /// Opens a dialog for updating a tag goal
  void _handleEditGoal(TagGoal goal) {
    Get.dialog(
      TagGoalForm(
        config: FormConfig(
          formKey: _editTagGoalFormKey,
          title: "Edit a goal",
          submitText: "Save",
          viewType: FormViewType.dialog,
          initialValue: goal,
          onSubmit: (TagGoal updatedGoal) async {
            setState(() {
              _goalsController[_goalsController.indexOf(goal)] = updatedGoal;
            });
            Get.back();
          },
        ),
      ),
    );
  }

  /// Opens a confirm dialog for deleting a tag goal
  void _handleDeleteGoal(TagGoal goal) {
    Get.dialog(
      ConfirmDialog(
        cancelText: "Cancel",
        onCancel: Get.back,
        confirmText: "Delete",
        onConfirm: () {
          setState(() {
            _goalsController.remove(goal);
            Get.back();
          });
        },
        titleText: "Remove a goal",
        description: "Are you sure you want to remove this goal?",
      ),
    );
  }

  List<Widget> _buildGoalsSection() {
    List<Widget> goals = [];

    for (var goal in _goalsController) {
      goals.add(
        Card.outlined(
          key: UniqueKey(),
          child: ListTile(
            title: Text("${goal.title}: ${goal.targetMinutes} minutes"),
            subtitle: Text(
              goal.weekdays
                  .map((w) => Const.defaults.weekdays[w - 1].label)
                  .join(", "),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _handleEditGoal(goal),
                  icon: Icon(Icons.edit),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: () => _handleDeleteGoal(goal),
                  icon: Icon(Icons.delete),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return goals;
  }

  /// Map the initial value to form fields
  void _mapObjectToForm() {
    _titleController.text = widget.config.initialValue!.title;
    _colorController.text = widget.config.initialValue!.colorARGB.toRadixString(
      16,
    );
    _goalsController.clear();
    _goalsController.addAll(widget.config.initialValue!.goals);
  }

  /// Map the form field values to the result object
  Tag _mapFormToObject(Tag? initial) {
    Tag tag = initial ?? Tag();

    tag.title = _titleController.text;
    tag.colorARGB = int.parse(_colorController.text, radix: 16);

    tag.goals = _goalsController;

    return tag;
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

        // Goals section
        SectionTitleFormField(
          title: "Goals",
          topPadding: true,
          trailing: IconButton(
            onPressed: _handleAddGoal,
            icon: Icon(Icons.add),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ),
        ..._buildGoalsSection(),
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
