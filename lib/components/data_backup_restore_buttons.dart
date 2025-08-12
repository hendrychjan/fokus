import 'package:flutter/material.dart';

class DataBackupRestoreButtons extends StatelessWidget {
  const DataBackupRestoreButtons({super.key});

  void _handleBackupData() {}

  void _handleRestoreData() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: _handleBackupData,
            label: Text("Back up"),
            icon: Icon(Icons.backup),
          ),
          SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: _handleRestoreData,
            label: Text("Restore"),
            icon: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}
