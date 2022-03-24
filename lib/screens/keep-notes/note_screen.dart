// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/screens/home_screen.dart';
import 'package:googlesineintry/thems.dart';

import '../../models/note.dart';
import '../../models/note.dart';
import '../../resorces/commonfunctions.dart';
import '../../resorces/local_data_bace.dart';

class NoteView extends StatefulWidget {
  Note? note;

  NoteView({Key? key, required this.note}) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late String newTitle;

  late String newContent;

  @override
  void initState() {
    super.initState();
    newTitle = widget.note!.title.toString();
    newContent = widget.note!.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: (() async {
              await updateNote();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await AuthMethods.pinNoteFireBace(widget.note);
                // await NotesDatabase.instance.pinNote(widget.note);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icon(
                  widget.note!.pin ? Icons.push_pin : Icons.push_pin_outlined)),
          IconButton(
            //////archive/////
            splashRadius: 17,
            onPressed: () async {
              await AuthMethods.archiveNoteFireBace(widget.note);
              await NotesDatabase.instance.archNote(widget.note);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(widget.note!.isArchieve
                ? Icons.archive
                : Icons.archive_outlined),
          ),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                deleteNode();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Form(
            child: TextFormField(
              initialValue: newTitle,
              cursorColor: white,
              onChanged: (value) {
                newTitle = value;
              },
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8))),
            ),
          ),
          Container(
              height: 300,
              child: Form(
                child: TextFormField(
                  onChanged: (value) {
                    newContent = value;
                  },
                  initialValue: newContent,
                  cursorColor: white,
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Note",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),
              ))
        ]),
      ),
    );
  }

  Future updateNote() async {
    Note newNote = Note(
        content: newContent,
        title: newTitle,
        // createdTime: widget.note!.createdTime,
        pin: false,
        id: widget.note!.id,
        isArchieve: false);

    log(widget.note!.id.toString() + "soijfgoiegneraoigh8re");
    DataBaseFunctionalty.updateNotes(newNote);
    // await NotesDatabase.instance.updateNote(newNote);

    ////////////////////////////////////
  }

  void deleteNode() async {
    // await NotesDatabase.instance.delteNote(widget.note.id!);
    log('hhhhhhhhhhhhhhhhhhhhhhhh');
    await DataBaseFunctionalty.deleteNote(widget.note!.id);

    //add snackbar
  }
}
