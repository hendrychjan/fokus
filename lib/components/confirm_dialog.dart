import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String titleText;
  final String? description;
  final String confirmText;
  final String cancelText;
  final void Function() onConfirm;
  final void Function() onCancel;
  const ConfirmDialog({
    super.key,
    required this.titleText,
    this.description,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(description ?? ""),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText, style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText, style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
