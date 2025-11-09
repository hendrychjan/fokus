import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String titleText;
  final String? description;
  final String confirmText;
  final void Function() onConfirm;
  const InfoDialog({
    super.key,
    required this.titleText,
    this.description,
    this.confirmText = "Ok",
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(description ?? ""),
      actions: [TextButton(onPressed: onConfirm, child: Text(confirmText))],
    );
  }
}
