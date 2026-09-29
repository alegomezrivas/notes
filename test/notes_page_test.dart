import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notas/core/error/failures.dart';
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

Widget app(List<Note> notes) {
  return ChangeNotifierProvider(
    create: (_) => NoteProvider(repository: FakeRepository(notes)),
    child: MaterialApp(
      theme: ThemeData.dark(useMaterial3: false),
      home: const NotePage(),
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
}
