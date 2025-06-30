import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDialog<T> extends StatelessWidget {
  final String titleText;
  final String contentText;
  final Future<void> Function(T deleteTarget) onDelete;
  final T deleteTarget;

  const DeleteDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.onDelete,
    required this.deleteTarget,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () async {
            await onDelete(deleteTarget);
            Get.back();
          },
          child: Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
