import 'package:dartz/dartz.dart';
import 'package:notas/features/core/error/failures.dart';
import 'package:notas/features/notes/domain/entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, void>> addNote(Note note);
  Future<Either<Failure, void>> editNote(int index, Note note);
  Future<Either<Failure, void>> deleteNote(int index);
  Future<Either<Failure, List<Note>>> getAllNotes();
}
