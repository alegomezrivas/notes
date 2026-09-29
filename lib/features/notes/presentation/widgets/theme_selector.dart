import 'package:flutter/material.dart';
import 'package:notas/core/theme/app_theme.dart';
import 'package:notas/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

/// App bar button that lets the user choose automatic, light or dark theme.
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  static const _options = <ThemeMode, (String, IconData)>{
    ThemeMode.system: ('Automático', Icons.brightness_auto),
    ThemeMode.light: ('Claro', Icons.light_mode),
    ThemeMode.dark: ('Oscuro', Icons.dark_mode),
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<ThemeProvider>();
    return PopupMenuButton<ThemeMode>(
      tooltip: 'Tema',
      icon: Icon(Icons.brightness_6, color: colors.text),
      color: colors.surface,
      initialValue: provider.mode,
      onSelected: provider.setMode,
      itemBuilder: (context) => [
        for (final entry in _options.entries)
          PopupMenuItem<ThemeMode>(
            value: entry.key,
            child: Row(
              children: [
                Icon(
                  entry.value.$2,
                  size: 20,
                  color: entry.key == provider.mode
                      ? colors.accent
                      : colors.textMuted,
                ),
                const SizedBox(width: 12),
                Text(
                  entry.value.$1,
                  style: TextStyle(
                    color: entry.key == provider.mode
                        ? colors.accent
                        : colors.text,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
