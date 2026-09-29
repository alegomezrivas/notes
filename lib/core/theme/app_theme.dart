import 'package:flutter/material.dart';

/// Colors of the Notas design system, one instance per theme.
///
/// Read them with `context.colors`. Values match the design system tokens;
/// the dark theme is the original look of the app.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.canvas,
    required this.appBar,
    required this.surface,
    required this.iconMuted,
    required this.text,
    required this.textMuted,
    required this.textEditor,
    required this.textHint,
    required this.accent,
    required this.accentStrong,
    required this.onAccent,
    required this.snackbar,
    required this.onSnackbar,
    required this.snackbarAction,
    required this.invertEmptyArt,
  });

  final Color canvas;
  final Color appBar;
  final Color surface;
  final Color iconMuted;
  final Color text;
  final Color textMuted;
  final Color textEditor;
  final Color textHint;
  final Color accent;
  final Color accentStrong;
  final Color onAccent;
  final Color snackbar;
  final Color onSnackbar;
  final Color snackbarAction;

  /// The empty-state art is pale, so it is inverted on a light canvas.
  final bool invertEmptyArt;

  static const dark = AppColors(
    canvas: Color(0xFF000000),
    appBar: Color(0xFF141218),
    surface: Color(0xFF212121),
    iconMuted: Color(0xFF424242),
    text: Color(0xFFFFFFFF),
    textMuted: Color(0xFF9E9E9E),
    textEditor: Color(0xB3FFFFFF),
    textHint: Color(0x4DFFFFFF),
    accent: Color(0xFFFFB300),
    accentStrong: Color(0xFFFFA000),
    onAccent: Color(0xFFFFFFFF),
    snackbar: Color(0x8A000000),
    onSnackbar: Color(0xFFFFFFFF),
    snackbarAction: Color(0xFFFFB300),
    invertEmptyArt: false,
  );

  static const light = AppColors(
    canvas: Color(0xFFFFFFFF),
    appBar: Color(0xFFF7F7F9),
    surface: Color(0xFFF2F2F2),
    iconMuted: Color(0xFF757575),
    text: Color(0xFF212121),
    textMuted: Color(0xFF616161),
    textEditor: Color(0xB3212121),
    textHint: Color(0x8A000000),
    accent: Color(0xFFA65F00),
    accentStrong: Color(0xFFFFA000),
    onAccent: Color(0xFF000000),
    snackbar: Color(0xFF323232),
    onSnackbar: Color(0xFFFFFFFF),
    snackbarAction: Color(0xFFFFB300),
    invertEmptyArt: true,
  );

  @override
  AppColors copyWith({
    Color? canvas,
    Color? appBar,
    Color? surface,
    Color? iconMuted,
    Color? text,
    Color? textMuted,
    Color? textEditor,
    Color? textHint,
    Color? accent,
    Color? accentStrong,
    Color? onAccent,
    Color? snackbar,
    Color? onSnackbar,
    Color? snackbarAction,
    bool? invertEmptyArt,
  }) {
    return AppColors(
      canvas: canvas ?? this.canvas,
      appBar: appBar ?? this.appBar,
      surface: surface ?? this.surface,
      iconMuted: iconMuted ?? this.iconMuted,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      textEditor: textEditor ?? this.textEditor,
      textHint: textHint ?? this.textHint,
      accent: accent ?? this.accent,
      accentStrong: accentStrong ?? this.accentStrong,
      onAccent: onAccent ?? this.onAccent,
      snackbar: snackbar ?? this.snackbar,
      onSnackbar: onSnackbar ?? this.onSnackbar,
      snackbarAction: snackbarAction ?? this.snackbarAction,
      invertEmptyArt: invertEmptyArt ?? this.invertEmptyArt,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      canvas: mix(canvas, other.canvas),
      appBar: mix(appBar, other.appBar),
      surface: mix(surface, other.surface),
      iconMuted: mix(iconMuted, other.iconMuted),
      text: mix(text, other.text),
      textMuted: mix(textMuted, other.textMuted),
      textEditor: mix(textEditor, other.textEditor),
      textHint: mix(textHint, other.textHint),
      accent: mix(accent, other.accent),
      accentStrong: mix(accentStrong, other.accentStrong),
      onAccent: mix(onAccent, other.onAccent),
      snackbar: mix(snackbar, other.snackbar),
      onSnackbar: mix(onSnackbar, other.onSnackbar),
      snackbarAction: mix(snackbarAction, other.snackbarAction),
      invertEmptyArt: t < 0.5 ? invertEmptyArt : other.invertEmptyArt,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

class AppTheme {
  const AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, AppColors.dark);

  static ThemeData get light => _build(Brightness.light, AppColors.light);

  static ThemeData _build(Brightness brightness, AppColors colors) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: false)
        : ThemeData.light(useMaterial3: false);
    return base.copyWith(
      primaryColor: brightness == Brightness.dark ? Colors.black : null,
      scaffoldBackgroundColor: colors.canvas,
      colorScheme: base.colorScheme.copyWith(secondary: colors.accent),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.appBar,
        foregroundColor: colors.text,
        elevation: 0,
        centerTitle: true,
      ),
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }
}
