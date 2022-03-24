// ignore: file_names
import 'dart:developer';

import 'package:googlesineintry/resorces/authentication.dart';

import '../models/note.dart';
import 'local_data_bace.dart';

class DataBaseFunctionalty {
  static saveNote(Note note) async {
    log("added");

    await NotesDatabase.instance.InsertEntry(note);
    // log(newNote.id.toString());
    // log("add Succfully");
    await AuthMethods.saveNote(note);
  }

  static updateNotes(Note note) async {
    // await AuthMethods.saveNote(note);
    await AuthMethods.updateNoteFirestore(note);
    await NotesDatabase.instance.updateNote(note);
    log("Updated Succfully");
  }

  static deleteNote(String id) async {
    // await NotesDatabase.instance.delteNote(note!.id);
    log('iiiiiiiiiiiiiiiiiiiiiiii');
    try {
      await AuthMethods.deleteNote(id);
    } catch (e) {
      log(e.toString());
    }

    log("Deleted Succfully");
  }

  static getAllNodes() async {
    log("one");
    return AuthMethods.getAllNotesFromFireStore();
  }
}
