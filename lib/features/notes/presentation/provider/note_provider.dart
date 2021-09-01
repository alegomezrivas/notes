import 'package:flutter/foundation.dart';
import 'package:notas/features/core/notifications/notifications.dart';
import 'package:notas/features/notes/domain/entities/note.dart';
import 'package:notas/features/notes/domain/repositories/note_repository_abstract.dart';

class NoteProvider with ChangeNotifier {
  NoteProvider({this.repository});

  final NoteRepository repository;

  bool _isLoading = false;
  List<Note> _notes = [];
  Note _note;

  get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Note> get notes => _notes;

  set notes(List<Note> value) {
    _notes = value;
    notifyListeners();
  }

  Note get note => _note;

  set note(Note value) {
    _note = value;
    notifyListeners();
  }

  Future<void> addNotes(Note note) async {
    if (note.title.isNotEmpty || note.content.isNotEmpty) {
      isLoading = true;
      final result = await repository.addNote(note);
      isLoading = false;
      result.fold(
        (_) {
          // show exception
          createNoteNotification(Status.error);
        },
        (_) {
          createNoteNotification(Status.add);
          getAllNotes();
        },
      );
    }
  }

  Future<void> editNotes(int index, Note note) async {
    isLoading = true;
    final result = await repository.editNote(index, note);
    isLoading = false;
    result.fold(
      (_) {
        // show exception
        createNoteNotification(Status.error);
      },
      (_) {
        getAllNotes();
      },
    );
  }

  Future<void> deleteNotes(int index) async {
    isLoading = true;
    final result = await repository.deleteNote(index);
    isLoading = false;
    result.fold(
      (_) {
        // show exception
        createNoteNotification(Status.error);
      },
      (_) {
        createNoteNotification(Status.remove);
        getAllNotes();
      },
    );
  }

  Future<void> getAllNotes() async {
    isLoading = true;
    final result = await repository.getAllNotes();
    isLoading = false;
    result.fold(
      (_) {
        // show exception
        createNoteNotification(Status.error);
      },
      (values) {
        notes = values;
      },
    );
  }
}
