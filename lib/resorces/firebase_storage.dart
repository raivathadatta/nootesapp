import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/note.dart';
import '../thems.dart';

class FireBaseStorage {
  FireBaseStorage._instance();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late DocumentSnapshot? lastDocument;

  static final FireBaseStorage _share = FireBaseStorage._instance();
  factory FireBaseStorage() => _share;

  get userId => FirebaseAuth.instance.currentUser?.uid;

  Future<List<Note>> getAllNotesFromFireStore() async {
    List<Note> notes = [];
    try {
      final querySnapshot =
          await users.doc(userId).collection("NoteData").get();

      for (var result in querySnapshot.docs) {
        Map<String, dynamic> tempNote = result.data();

        notes.add(Note(
          pin: tempNote['pin'],
          isArchieve: tempNote['isArchieve'],
          title: tempNote['title'] as String,
          content: tempNote['content'] as String,
          id: tempNote['id'] as String,
          //  dateTime:tempNote['time'],
        ));
      }

      log("before return" + notes.length.toString());

      return notes;
    } catch (e) {
      log(e.toString());
    }

    return notes;
  }

  getUserById(int element) async {
    return await users
        .doc(userId)
        .collection("NoteData")
        .doc(element.toString());
  }

  pinNoteFireBace(Note note) async {
    await users
        .doc(userId)
        .collection("NoteData")
        .doc(note.id.toString())
        .update({
      "pin": !note.pin,
    });
  }

  archiveNoteFireBace(Note note) async {
    await users
        .doc(userId)
        .collection("NoteData")
        .doc(note.id.toString())
        .update({
      "isArchieve": !note.isArchieve,
    });
  }

  Future getAllNotesPagination() async {
    List<Note> notes = [];

    int _limit = 10;

    try {
      final query = users.doc(userId).collection("NoteData");

      final querySnapshot = await query.orderBy('title').limit(_limit).get();

      lastDocument = querySnapshot.docs.last;

      // lastDocument = querySnapshot.docs[querySnapshot.size - 1];
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> tempNote = result.data();

        notes.add(Note(
          pin: tempNote['pin'],
          isArchieve: tempNote['isArchieve'],
          title: tempNote['title'] as String,
          content: tempNote['content'] as String,
          id: tempNote['id'] as String,
          // dateTime: DateTime.now(),
        ));
      }

      return notes;
    } catch (e) {
      log(e.toString());
    }
  }

  getMoreNotesFromFB() async {
    List<Note> notes = [];

    int _limit = listCount; //10
    if (lastDocument != null) {
      try {
        final query = users.doc(userId).collection("NoteData").orderBy('title');

        var querySnapshot =
            await query.startAfterDocument(lastDocument!).limit(_limit).get();

        lastDocument = querySnapshot.docs.last;
        log(lastDocument.toString() + "sodjglsknglksdnglksdngfldnsgsdgsd");

        notes = querySnapshot.docs
            .map((doc) => Note.formDocument(doc.data()))
            .toList();
        log("end");
        return notes;
      } catch (e) {
        if (e.toString() == "Bad state: No element") {
          log("this is last end");
          throw "theendlist";
        }
      }
    }
  }

  deleteNote(String id) async {
    log('indelette');
    try {
      await users
          .doc(userId)
          .collection("NoteData")
          .doc(id.toString())
          .delete()
          .then((value) => log("Deleted Succfully"));
    } catch (e) {
      log(e.toString());
    }
  }

  updateNoteFirestore(Note note) async {
    log(note.id.toString() + "inUpdate");
    await users
        .doc(userId)
        .collection("NoteData")
        .doc(note.id.toString())
        .update({
      "title": note.title.toString(),
      "content": note.content.toString()
    });
    log("updated Succfully");
  }

  saveNote(Note note) async {
    log('message');

    try {
      var doc = users.doc(userId).collection("NoteData").doc();

      final newNoteset = {
        'title': note.title,
        'content': note.content,
        'id': doc.id,
        'pin': note.pin,
        'isArchieve': note.isArchieve,
      };

      doc.set(newNoteset);
    } catch (e) {
      log(e.toString());
    }
  }

  getArchiveList() async {
    List<Note> lists = await getAllNotesFromFireStore();
    List<Note> archiveList = [];
    for (var element in lists) {
      if (element.isArchieve) {
        archiveList.add(element);
      }
    }
    log(archiveList.length.toString() + "aaaaaaa");

    return archiveList;
  }
}
