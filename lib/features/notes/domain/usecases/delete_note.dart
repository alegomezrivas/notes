import 'package:dartz/dartz.dart';
import 'package:notas/core/usecase/usecase.dart';
import 'package:notas/core/error/failures.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

class DeleteNote implements UseCase<void, Params> {
  DeleteNote(this.repository);

  final NoteRepository? repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository!.deleteNote(params.index);
  }
}
