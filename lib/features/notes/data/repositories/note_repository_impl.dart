import 'package:notas/core/error/exceptions.dart';
import 'package:notas/features/notes/data/datasources/note_local_data_source.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

typedef Future<void> _Function();

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl({required this.localDataSource});

  final NoteLocalDataSource? localDataSource;

  @override
  Future<Either<Failure, void>> addNote(Note note) async {
    return await _callRepository(() {
      return localDataSource!.addNote(note);
    });
  }

  @override
  Future<Either<Failure, void>> deleteNote(int index) async {
    return await _callRepository(() {
      return localDataSource!.deleteNote(index);
    });
  }

  @override
  Future<Either<Failure, void>> editNote(int? index, Note note) async {
    return await _callRepository(() {
      return localDataSource!.editNote(index, note);
    });
  }

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final result = await localDataSource!.getAllNotes();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, bool>> _callRepository(
      _Function executeHiveFunction) async {
    try {
      await executeHiveFunction();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
