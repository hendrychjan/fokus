import 'package:flutter/material.dart';
import 'package:fokus/forms/record_form.dart';
import 'package:fokus/models/record.dart';
import 'package:get/get.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<FormState> updateRecordFormKey = GlobalKey<FormState>();

  /// Update a record in the database
  Future<void> _handleSaveRecord(Record record) async {
    await record.save();
    Get.back();
  }

  /// Delete a tag from the database
  Future<void> _handleDeleteRecord(Record record) async {
    await record.delete();
    Get.back();
  }

  /// Open a dialog for editing tags
  void _openEditDialog(Record record) {
    Get.to(
      RecordForm(
        formKey: updateRecordFormKey,
        submitText: "Update",
        title: "Update a record",
        initialValue: record,
        onSubmit: _handleSaveRecord,
        onDelete: _handleDeleteRecord,
      ),
    );
  }

  /// Create a list view item from a tag
  Widget _recordItemBuilder(
    BuildContext context,
    int index,
    List<Record> records,
  ) {
    final record = records[index];

    return GestureDetector(
      onTap: () => _openEditDialog(record),
      child: ListTile(
        title: Text("${record.start} - ${record.end}"),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History"), centerTitle: true),
      body: StreamBuilder<List<Record>>(
        stream: Record.getAllStream(),
        builder: (context, snapshot) {
          // Check the stream state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No records yet'));
          }

          // Create list items from stream's items
          final records = snapshot.data!;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) =>
                _recordItemBuilder(context, index, records),
          );
        },
      ),
    );
  }
}
