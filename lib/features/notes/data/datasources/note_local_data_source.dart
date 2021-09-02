import 'package:hive/hive.dart';
import 'package:notas/core/error/exceptions.dart';
import 'package:notas/features/notes/domain/entities/note.dart';

abstract class NoteLocalDataSource {
  /// Gets the cached [NoteModel] from the Hive.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<void> addNote(Note note);

  Future<void> editNote(int? index, Note note);

  Future<void> deleteNote(int index);

  Future<List<Note>> getAllNotes();
}

class NoteLocalDataSourceImpl extends NoteLocalDataSource {
  NoteLocalDataSourceImpl({this.hive});

  final Box<Note>? hive;

  @override
  Future<void> addNote(Note note) async {
    try {
      await hive!.add(note);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNote(int index) async {
    try {
      await hive!.deleteAt(index);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> editNote(int? index, Note note) async {
    try {
      hive!.putAt(index!, note);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<Note>> getAllNotes() async {
    try {
      return hive!.values.toList();
    } catch (_) {
      throw CacheException();
    }
  }
}
