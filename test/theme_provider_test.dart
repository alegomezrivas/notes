import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:notas/core/theme/theme_provider.dart';

void main() {
  late Directory dir;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('notas_theme_test');
    Hive.init(dir.path);
  });

  tearDown(() async {
    await Hive.close();
    dir.deleteSync(recursive: true);
  });

  test('defaults to following the system', () async {
    final box = await Hive.openBox<String>('settings');
    expect(ThemeProvider(box: box).mode, ThemeMode.system);
  });

  test('remembers the chosen theme between launches', () async {
    var box = await Hive.openBox<String>('settings');
    await ThemeProvider(box: box).setMode(ThemeMode.dark);
    await box.close();

    box = await Hive.openBox<String>('settings');
    expect(ThemeProvider(box: box).mode, ThemeMode.dark);
  });

  test('ignores an unknown stored value', () async {
    final box = await Hive.openBox<String>('settings');
    await box.put('themeMode', 'sepia');
    expect(ThemeProvider(box: box).mode, ThemeMode.system);
  });

  test('notifies listeners only when the mode changes', () async {
    final provider = ThemeProvider();
    var calls = 0;
    provider.addListener(() => calls++);

    await provider.setMode(ThemeMode.system);
    expect(calls, 0);
    await provider.setMode(ThemeMode.light);
    expect(calls, 1);
  });
}
