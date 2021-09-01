import 'package:equatable/equatable.dart';
import 'package:notas/features/core/usecase/usecase.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:notas/features/core/error/failures.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

class AddNote implements UseCase<void, Params> {
  AddNote(this.repository);

  final NoteRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addNote(params.note);
  }
}

class Params extends Equatable {
  final Note note;

  Params({@required this.note});

  @override
  List<Object> get props => [note];
}
