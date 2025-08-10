import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class ColorFormField extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final Function(Color)? onChange;

  const ColorFormField({
    super.key,
    required this.controller,
    this.decoration,
    this.onChange,
    this.validator,
  });

  @override
  State<ColorFormField> createState() => _ColorFormFieldState();
}

class _ColorFormFieldState extends State<ColorFormField> {
  Color _pickerColor = Colors.green;
  Color _currentColor = Colors.green;
  final TextEditingController _innerFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isNotEmpty) {
      setState(() {
        _currentColor = Color(int.parse(widget.controller.text));
        _pickerColor = _currentColor;
      });

      _innerFieldController.text = _pickerColor.toHexString(
        includeHashSign: true,
      );
    }
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => _pickerColor = color);
  }

  void _openDialog() {
    Get.dialog(
      AlertDialog(
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: Get.back,
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // Save the selected color in the controller
              widget.controller.text = _pickerColor.toHexString();

              // Call the onChange hook if supplied
              if (widget.onChange != null) {
                widget.onChange!(_pickerColor);
              }

              // Display the hex string in the inner controller
              _innerFieldController.text = _pickerColor.toHexString(
                includeHashSign: true,
              );
              Get.back();
            },
            child: Text("Select"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _innerFieldController,
      decoration: widget.decoration,
      validator: widget.validator,
      onTap: _openDialog,
    );
  }
}
