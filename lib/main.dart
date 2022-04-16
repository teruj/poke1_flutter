import 'dart:ffi';

import 'package:flutter/material.dart';
import './poke_list_item.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => themeMode = val));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Flutter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: const TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0 ? const PokeList() : const Settings(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => {
                setState(
                  () => currentbnb = index,
                )
              },
          currentIndex: currentbnb,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'setting'),
          ]),
    );
  }
}

class PokeList extends StatelessWidget {
  const PokeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: 898,
      itemBuilder: (context, index) => PokeListItem(index: index),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => _themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/Light Mode'),
          trailing: Text((_themeMode == ThemeMode.system)
              ? 'System'
              : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
          onTap: () async {
            var ret = await Navigator.of(context).push<ThemeMode>(
              MaterialPageRoute(
                builder: (context) => ThemeModeSelectionPage(init: _themeMode),
              ),
            );

            setState(() => _themeMode = ret!);
            await saveThemeMode(_themeMode);
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
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({
    Key? key,
    required this.init,
  }) : super(key: key);
  final ThemeMode init ;

  @override
  // State<ThemeModeSelectionPage> createState() => _ThemeModeSelectionPageState();
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;

  @override
  void initState() {
    super.initState();
    _current = widget.init;//statefullwidgetで受け取った値を使う場合widget.xxxを使う
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
              onPressed: () =>
                  Navigator.pop<ThemeMode>(context, _current),
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

int modeToVal(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return 1;
    case ThemeMode.dark:
      return 2;
    case ThemeMode.light:
      return 3;
    default:
      return 0;
  }
}

ThemeMode valToMode(int val) {
  switch (val) {
    case 1:
      return ThemeMode.system;
    case 2:
      return ThemeMode.dark;
    case 1:
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}

Future<void> saveThemeMode(ThemeMode mode) async {
  final pref = await SharedPreferences.getInstance();
  pref.setInt('theme_mode', modeToVal(mode));
}

Future<ThemeMode> loadThemeMode() async {
  final pref = await SharedPreferences.getInstance();
  final ret = valToMode(pref.getInt('theme_mode') ??
      0); // ??の左がnullの場合、右の変数を返す。左がnullでなければその時点でその変数を返す。
  return ret;
}
