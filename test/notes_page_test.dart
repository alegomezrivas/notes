import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notas/core/error/failures.dart';
import 'package:notas/core/theme/app_theme.dart';
import 'package:notas/core/theme/theme_provider.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';
import 'package:notas/features/notes/presentation/pages/notes_page.dart';
import 'package:notas/features/notes/presentation/provider/note_provider.dart';
import 'package:provider/provider.dart';

class FakeRepository implements NoteRepository {
  FakeRepository(this.notes);

  final List<Note> notes;

  @override
  Future<Either<Failure, void>> addNote(Note note) async => const Right(null);

  @override
  Future<Either<Failure, void>> editNote(int? index, Note note) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> deleteNote(int index) async =>
      const Right(null);

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async => Right(notes);
}

Widget app(List<Note> notes, {ThemeData? theme, ThemeProvider? themes}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => themes ?? ThemeProvider()),
      ChangeNotifierProvider(
        create: (_) => NoteProvider(repository: FakeRepository(notes)),
      ),
    ],
    child: Builder(
      builder: (context) => MaterialApp(
        theme: theme ?? AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: theme != null
            ? (theme.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light)
            : context.watch<ThemeProvider>().mode,
        home: const NotePage(),
      ),
    ),
  );
}

void main() {
  testWidgets('shows the empty state when there are no notes', (tester) async {
    await tester.pumpWidget(app([]));
    await tester.pump();

    expect(find.text('Notas'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(GridView), findsNothing);
  });

  testWidgets('lists saved notes in a grid', (tester) async {
    await tester.pumpWidget(
      app([Note(title: 'Lista de compras', content: 'Pan y leche')]),
    );
    await tester.pump();

    expect(find.text('Lista de compras'), findsOneWidget);
    expect(find.text('Pan y leche'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  for (final entry in {'light': AppTheme.light, 'dark': AppTheme.dark}.entries) {
    testWidgets('uses the ${entry.key} canvas and card colors', (tester) async {
      await tester.pumpWidget(
        app([Note(title: 'Ideas', content: 'Texto')], theme: entry.value),
      );
      await tester.pump();

      final colors = entry.value.extension<AppColors>()!;
      expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
          colors.canvas);
      expect(tester.widget<Card>(find.byType(Card)).color, colors.surface);
      expect(tester.widget<Text>(find.text('Ideas')).style?.color, colors.text);
    });
  }

  testWidgets('theme selector switches between light and dark',
      (tester) async {
    final themes = ThemeProvider();
    await tester.pumpWidget(app([], themes: themes));
    await tester.pump();

    Color canvas() =>
        tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor!;

    // Follows the system (light in the test environment) by default.
    expect(canvas(), AppColors.light.canvas);

    await tester.tap(find.byTooltip('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Oscuro'));
    await tester.pumpAndSettle();
    expect(themes.mode, ThemeMode.dark);
    expect(canvas(), AppColors.dark.canvas);

    await tester.tap(find.byTooltip('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Claro'));
    await tester.pumpAndSettle();
    expect(themes.mode, ThemeMode.light);
    expect(canvas(), AppColors.light.canvas);
  });
}
