import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:notas/core/usecase/usecase.dart';
import 'package:notas/core/error/failures.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

class EditNote implements UseCase<void, Params> {
  EditNote(this.repository);

  final NoteRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.editNote(params.index, params.note);
  }
}

class Params extends Equatable {
  final int index;
  final Note note;

  Params({@required this.index, @required this.note});

  @override
  List<Object> get props => [index, note];
}
