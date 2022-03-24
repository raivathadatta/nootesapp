import 'package:googlesineintry/models/note.dart';

class NewNote {
  static Notetojson(Note note) {
    final newNote = {
      // 'createdTime':
      'title': note.title,
      'content': note.content,
      'id': note.id,
      'pin': note.pin,
      'isArchieve': note.isArchieve,
      // 'createdTime': DateTime.now(),
    };
  }

  // NewNote(this.id, this.pin, this.title, this.content, this.isArchieve);
}
