import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Holds the theme the user picked and remembers it between launches.
///
/// [ThemeMode.system] (the default) follows the device setting.
class ThemeProvider with ChangeNotifier {
  ThemeProvider({Box<String>? box}) : _box = box {
    _mode = _parse(box?.get(_key));
  }

  static const _key = 'themeMode';

  final Box<String>? _box;
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  Future<void> setMode(ThemeMode value) async {
    if (value == _mode) return;
    _mode = value;
    notifyListeners();
    await _box?.put(_key, value.name);
  }

  static ThemeMode _parse(String? name) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}
