import 'package:flutter/material.dart';
import 'package:fokus/components/form/color_form_field.dart';
import 'package:fokus/components/form/select_form_field.dart';
import 'package:fokus/components/form/spacer_form_field.dart';
import 'package:fokus/services/app_controller.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final List<_ThemeTypeOption> _themeTypeOptions = [
    _ThemeTypeOption("System", ThemeMode.system),
    _ThemeTypeOption("Light", ThemeMode.light),
    _ThemeTypeOption("Dark", ThemeMode.dark),
  ];

  late ThemeMode _themeModeController;
  final TextEditingController _themeColorController = TextEditingController();

  void _handleChangeTheme(_ThemeTypeOption? modeOpt) {
    if (modeOpt == null) return;

    // Save and apply theme mode
    AppController.to.settingsService.appSettings.themeMode = modeOpt.value;
    AppController.to.settingsService.saveSettings();
    AppController.to.settingsService.updateAppTheme();

    setState(() {
      _themeModeController = modeOpt.value;
    });
  }

  void _handleChangeColor(Color color) {
    // Save and apply theme mode
    AppController.to.settingsService.appSettings.themeSeedColorARGB = color
        .toARGB32();
    AppController.to.settingsService.saveSettings();
    AppController.to.settingsService.updateAppTheme();
  }

  @override
  void initState() {
    _themeModeController =
        AppController.to.settingsService.appSettings.themeMode;
    _themeColorController.text = AppController
        .to
        .settingsService
        .appSettings
        .themeSeedColorARGB
        .toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SelectFormField<_ThemeTypeOption>(
              options: _themeTypeOptions,
              itemTitleBuilder: (_ThemeTypeOption opt) => opt.label,
              onSaved: (_ThemeTypeOption? sel) {
                if (sel == null) return;

                setState(() {
                  _themeModeController = sel.value;
                });
              },
              onChanged: _handleChangeTheme,
              decoration: InputDecoration(
                labelText: "Theme type",
                prefixIcon: Icon(Icons.brightness_4),
                border: OutlineInputBorder(),
              ),
              initialValue: _themeTypeOptions.firstWhere(
                (_ThemeTypeOption opt) => opt.value == _themeModeController,
              ),
            ),
            SpacerFormField(),
            ColorFormField(
              controller: _themeColorController,
              decoration: InputDecoration(
                labelText: "Color theme",
                prefixIcon: Icon(Icons.color_lens),
                border: OutlineInputBorder(),
              ),
              onChange: _handleChangeColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeTypeOption {
  String label;
  ThemeMode value;

  _ThemeTypeOption(this.label, this.value);
}
