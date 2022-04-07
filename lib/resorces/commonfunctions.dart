// ignore: file_names
import 'dart:developer';

import '../models/note.dart';
import 'firebase_storage.dart';
import 'local_data_bace.dart';

class DataBaseFunctionalty {
  static saveNote(Note note) async {
    log("added");

    await FireBaseStorage().saveNote(note);
  }

  static updateNotes(Note note) async {
    await NotesDatabase.instance.updateNote(note);
    log("Updated Succfully");
  }

  static deleteNote(String id) async {
    try {
      await FireBaseStorage().deleteNote(id);
    } catch (e) {
      log(e.toString());
    }

    log("Deleted Succfully");
  }

  static Future<List<Note>> getAllNodes(int limit) async {
    return await FireBaseStorage().getAllNotesFromFireStore();
  }
}
