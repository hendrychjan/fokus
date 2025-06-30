import 'package:flutter/material.dart';
import 'package:fokus/forms/record_form.dart';
import 'package:fokus/models/record.dart';
import 'package:get/get.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final GlobalKey<FormState> createRecordFormKey = GlobalKey<FormState>();

  Future<void> _handleSaveRecord(Record record) async {
    await record.save();
    Get.back();
  }

  void _openCreateDialog() {
    Get.to(
      RecordForm(
        formKey: createRecordFormKey,
        submitText: "Save",
        title: "Create record",
        onSubmit: _handleSaveRecord,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        child: Icon(Icons.more_time_outlined),
      ),
      body: Center(child: Text("Timer")),
    );
  }
}
