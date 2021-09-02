import 'package:notas/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({required String? title, required String? content})
      : super(title: title, content: content);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'] as String?,
      content: json['content'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
