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
  final List<_SelectOption<ThemeMode>> _themeTypeOptions = [
    _SelectOption("System", ThemeMode.system),
    _SelectOption("Light", ThemeMode.light),
    _SelectOption("Dark", ThemeMode.dark),
  ];

  final List<_SelectOption<bool>> _wakelockModeOptions = [
    _SelectOption("Enabled during active session", true),
    _SelectOption("Always disabled", false),
  ];

  late ThemeMode _themeModeController;
  final TextEditingController _themeColorController = TextEditingController();
  late bool _wakelockModeController;

  void _handleChangeWakelockMode(_SelectOption<bool>? modeOpt) {
    if (modeOpt == null) return;

    // Save wakelock mode settings
    AppController.to.settingsService.appSettings.wakelockEnabled =
        modeOpt.value;
    AppController.to.settingsService.appSettings.save();

    setState(() {
      _wakelockModeController = modeOpt.value;
    });
  }

  void _handleChangeTheme(_SelectOption<ThemeMode>? modeOpt) {
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
        .toRadixString(16);
    _wakelockModeController =
        AppController.to.settingsService.appSettings.wakelockEnabled;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme mode select
            SelectFormField<_SelectOption<ThemeMode>>(
              options: _themeTypeOptions,
              itemTitleBuilder: (_SelectOption opt) => opt.label,
              onSaved: (_SelectOption? sel) {
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
                (_SelectOption opt) => opt.value == _themeModeController,
              ),
            ),
            SpacerFormField(),

            // Theme color select
            ColorFormField(
              controller: _themeColorController,
              decoration: InputDecoration(
                labelText: "Color theme",
                prefixIcon: Icon(Icons.color_lens),
                border: OutlineInputBorder(),
              ),
              onChange: _handleChangeColor,
            ),
            SpacerFormField(),

            // Wakelock mode select
            SelectFormField<_SelectOption<bool>>(
              options: _wakelockModeOptions,
              itemTitleBuilder: (_SelectOption opt) => opt.label,
              onSaved: (_SelectOption? sel) {
                if (sel == null) return;

                setState(() {
                  _themeModeController = sel.value;
                });
              },
              onChanged: _handleChangeWakelockMode,
              decoration: InputDecoration(
                labelText: "Wakelock",
                prefixIcon: Icon(Icons.display_settings),
                border: OutlineInputBorder(),
              ),
              initialValue: _wakelockModeOptions.firstWhere(
                (_SelectOption opt) => opt.value == _wakelockModeController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectOption<T> {
  String label;
  T value;

  _SelectOption(this.label, this.value);
}
