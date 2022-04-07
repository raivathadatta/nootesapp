import 'package:googlesineintry/models/note.dart';

class NewNote {
  static Notetojson(Note note) {
    final newNote = {
      'title': note.title,
      'content': note.content,
      'id': note.id,
      'pin': note.pin,
      'isArchieve': note.isArchieve,
    };
  }
}
