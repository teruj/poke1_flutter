import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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