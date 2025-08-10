import 'package:flutter/material.dart';
import 'package:fokus/forms/settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: SettingsForm(),
    );
  }
}
