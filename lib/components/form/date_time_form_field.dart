import 'package:flutter/material.dart';

class DateTimeFormField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(DateTime)? onChange;

  DateTimeFormField({
    super.key,
    required this.controller,
    this.decoration,
    this.validator,
    this.onChange,
  }) {
    _innerFieldController.text = controller.text;
  }

  final TextEditingController _innerFieldController = TextEditingController();

  /// Show a date-time picker and update the controller with the selected value
  Future<void> _pickDateTime(BuildContext context) async {
    DateTime initialDateTime =
        DateTime.tryParse(controller.text) ?? DateTime.now();

    // Let the user pick a date
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // No value was selected - exit
    if (selectedDate == null) return;

    // Let the user pick a time
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime),
    );

    // No value was selected - exit
    if (selectedTime == null) return;

    // Combine the selected date and time
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Save it in the outside controller as well as the inner, display one
    controller.text = selectedDateTime.toIso8601String();
    _innerFieldController.text = selectedDateTime.toString();

    if (onChange != null) onChange!(selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _innerFieldController,
      decoration: decoration,
      validator: validator,
      onTap: () => _pickDateTime(context),
    );
  }
}
