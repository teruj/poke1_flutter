import 'package:flutter/material.dart';
import './utils/theme_mode.dart';
import 'package:provider/provider.dart';

import './models/theme_mode.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // ThemeMode _themeMode = ThemeMode.system;

  // @override
  // void initState() {
  //   super.initState();
  //   loadThemeMode().then((val) => setState(() => _themeMode = val));
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(builder: (context, mode, child) {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((mode.mode == ThemeMode.system)
                ? 'System'
                : (mode.mode == ThemeMode.dark ? 'Dark' : 'Light')),
            onTap: () async {
              var ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                  builder: (context) => ThemeModeSelectionPage(init: mode.mode),
                ),
              );

              // setState(() => _themeMode = ret!);
              // await saveThemeMode(_themeMode);

              if (ret != null) {
                mode.update(ret);
              }
            },
          ),
          // SwitchListTile(
          //     title: const Text('Switch'), value: true, onChanged: (yes) => {}),
          // CheckboxListTile(
          //   title: const Text('Checkbox'),
          //   value: true,
          //   onChanged: (yes) => {},
          // ),
          // RadioListTile(
          //     title: const Text('Radio'),
          //     value: true,
          //     groupValue: true,
          //     onChanged: (yes) => {}),
        ],
      );
    });
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({
    Key? key,
    required this.init,
  }) : super(key: key);
  final ThemeMode init;

  @override
  // State<ThemeModeSelectionPage> createState() => _ThemeModeSelectionPageState();
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;

  @override
  void initState() {
    super.initState();
    _current = widget.init; //StatefulWidgetで受け取った値を使う場合widget.xxxを使う
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop<ThemeMode>(context, _current),
            ),
          ),
          RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: _current,
              onChanged: (val) => {setState(() => _current = val!)}),
          RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: _current,
              onChanged: (val) => {setState(() => _current = val!)}),
          RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: _current,
              onChanged: (val) => {setState(() => _current = val!)}),
        ],
      )),
    );
  }
}
