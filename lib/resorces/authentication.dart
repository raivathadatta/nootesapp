// ignore_for_file: deprecated_member_use, dead_code_on_catch_subtype

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesineintry/models/model.dart';

import 'package:googlesineintry/widgets/show_error.dart';

import '../models/note.dart';
import '../screens/login-signup/login_scree.dart';
import 'auth_exceptions.dart';
import 'local_data_bace.dart';

class AuthMethods {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const storage = FlutterSecureStorage();
  static final googleSignIn = GoogleSignIn();
  static late final UserCredential cred;

  static late String forwardEMail;

  static signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        log("person" + "email");
        final person = Person(
            firstName: firstname,
            phone: phone,
            lastName: lastname,
            email: email,
            uid: cred.user!.uid,
            password: password);

        final jsgon = {
          'firstName': person.firstName,
          'phone': person.phone,
          'lastName': person.lastName,
          'email': person.email,
          'uid': cred.user!.uid,
          'password': person.password
        };
        log(person.email);

        forwardEMail = person.email;
        await users
            .doc(cred.user!.uid)
            .set(jsgon)
            .then((value) => log(" Succfull"));
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///login user

  static login({required String email, required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await storage.write(key: 'uid', value: user.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  static signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      storage.delete(key: 'uid');
      googleSignIn.signOut();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginIn()));
    } catch (err) {
      ShowError.showError(err.toString(), context);
    }
  }

  static resetPassword(String email, BuildContext context) async {
    // bool res = false;
    await _auth.sendPasswordResetEmail(email: email);
  }

///////adding notes ot firestore DataBace

  static final userID =
      FirebaseAuth.instance.currentUser!.uid; /////////////////////////

  static saveNote(Note note) async {
    log('message');

    try {
      var doc = users
          .doc(userID) //////change to generlize
          .collection("NoteData")
          .doc();

      final newNoteset = {
        'title': note.title,
        'content': note.content,
        'id': doc.id,
        'pin': note.pin,
        'isArchieve': note.isArchieve,
      };

      log("after then///////////////////////////////////////////////////////////////////////////");
      doc.set(newNoteset);
      log("after then///////////////////////////////////////////////////////////////////////////");
      // .set(newNote);

    } catch (e) {
      log('pppppppppppppppppppppppppppppppppppppp');
      log(e.toString());
    }
  }

  static updateNoteFirestore(Note note) async {
    log(note.id.toString() + "inUpdate");
    await users
        .doc(userID) //////change to generlize
        .collection("NoteData")
        .doc(note.id.toString())
        .update({
      "title": note.title.toString(),
      "content": note.content.toString()
    });
    log("updated Succfully");
  }

  static deleteNote(String id) async {
    log('indelette');
    try {
      await users
          .doc(userID)
          .collection("NoteData")
          .doc(id.toString())
          .delete()
          .then((value) => log("Deleted Succfully"));
    } catch (e) {
      log(e.toString());
    }
  }

  static getAllNotes() async {
    await await users.doc(userID).collection("NoteData").get().then((value) {
      for (var element in value.docs) {
        Map note = element.data();
        NotesDatabase.instance
            .InsertEntry(Note(
                pin: false,
                title: note['title'],
                content: note['content'],
                isArchieve: false,
                id: note['id']))
            .then((value) => log(" retrived all the data"));
      }
    });

    // NotesDatabse.instance.InsertEntry(Note(title:note["Title"] , content : note["content"] , createdTime: note["date"] , pin: false, isArchieve: false));  //Add Notes In Database
  }

  static Future<List<Note>> getAllNotesFromFireStore() async {
    log("///////////////////////////////////////////////////////////////////////////////////////////;");
    List<Note> notes = [];
    try {
      await users
          .doc(userID)
          .collection("NoteData")
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          Map<String, dynamic> tempNote = result.data();

          notes.add(Note(
            pin:
                false, ////////////////////////////////////////////////////////////////////////////////////////
            isArchieve:
                false, /////////////////////////////pin : tempNote['pin'] as bool is not workimg /////////////////////////////////not qable to assain these values
            title: tempNote['title'] as String,
            content: tempNote['content'] as String,
            id: tempNote['id'] as String,
            // createdTime: tempNote['createdTime']
          ));
        }
      });

      return notes;
    } catch (e) {
      log(e.toString());
    }

    return notes;
  }

  static getUserById(int element) async {
    return await users
        .doc(userID) //////change to generlize
        .collection("NoteData")
        .doc(element.toString());
  }

  static pinNoteFireBace(Note? note) async {
    log("before adding pin");
    log(note!.id.toString());

    NotesImpNames.pin = (!note.pin ? 1 : 0) as String;
    await users
        .doc(userID) //////change to generlize
        .collection("NoteData")
        .doc(note.id.toString())
        .update({
      "pin": NotesImpNames.pin,
    });
  }

  static archiveNoteFireBace(Note? note) async {
    await users
        .doc(userID) //////change to generlize
        .collection("NoteData")
        .doc(note!.id.toString())
        .update({
      "isArchieve": {NotesImpNames.isArchive: !note.isArchieve ? 1 : 0},
    });
  }
}
