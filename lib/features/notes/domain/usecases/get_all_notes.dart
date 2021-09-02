import 'package:notas/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notas/core/usecase/usecase.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

class GetAllNotes implements UseCase<List<Note>, NoParams> {
  GetAllNotes(this.repository);

  final NoteRepository repository;

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) async {
    return await repository.getAllNotes();
  }
}
