// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:googlesineintry/resorces/firebase_storage.dart';
import 'package:googlesineintry/resorces/notification_managers.dart';
import 'package:googlesineintry/screens/home_screen.dart';
import 'package:googlesineintry/thems.dart';

import '../../models/note.dart';

import '../../resorces/commonfunctions.dart';

import 'notification_screeen.dart';

class CreateUpdateNote extends StatefulWidget {
  Note? note;

  CreateUpdateNote({Key? key, this.note}) : super(key: key);

  @override
  _CreateUpdateNoteState createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends State<CreateUpdateNote> {
  late TextEditingController titleTextEditingController;
  late TextEditingController contentTextEditingController;

  @override
  void initState() {
    super.initState();

    titleTextEditingController = TextEditingController();
    contentTextEditingController = TextEditingController();
    setUp();
  }

  @override
  void dispose() {
    super.dispose();
    contentTextEditingController.dispose();
    titleTextEditingController.dispose();
  }

  setUp() {
    if (widget.note != null) {
      titleTextEditingController.text = widget.note!.title!;
      contentTextEditingController.text = widget.note!.content;
    }
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
              log("in update");
              await updateNote();
              // NotificationManager()
              //     .callNotification(widget.note!.title!, 'context');
              // NotificationManager().callNotificationAfterDelay();
              log("in updatemmmmmm");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }),
            icon: const Icon(Icons.arrow_back_ios_outlined)),
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                log("message");
                await FireBaseStorage().pinNoteFireBace(widget.note!);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: Icon(widget.note?.pin ?? false
                  ? Icons.push_pin
                  : Icons.push_pin_outlined)),
          IconButton(
            //////archive/////
            splashRadius: 17,

            onPressed: () async {
              await FireBaseStorage().archiveNoteFireBace(widget.note!);

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: Icon(widget.note?.isArchieve ?? false
                ? Icons.archive
                : Icons.archive_outlined),
          ),
          IconButton(
            splashRadius: 17,
            splashColor: white,
            icon: const Icon(
              Icons.notification_add_outlined,
              color: white,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NotificationScreen(widget.note);
                  });
            },
          ),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await deleteNode();
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
              cursorColor: white,
              controller: titleTextEditingController,
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
          SizedBox(
              height: 300,
              child: Form(
                child: TextFormField(
                  controller: contentTextEditingController,
                  cursorColor: white,
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
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
    final String title = titleTextEditingController.text;
    final String content = contentTextEditingController.text;
    if (widget.note != null) {
      log(widget.note!.id.toString() + "soijfgoiegneraoigh8re");
      Note newNote = Note(
          content: content,
          title: title,
          pin: widget.note!.pin,
          id: widget.note!.id,
          isArchieve: widget.note!.isArchieve);
      DataBaseFunctionalty.updateNotes(newNote);
    } else {
      final newNote = Note(
        pin: false,
        title: title,
        content: content,
        isArchieve: false,
        id: "",
        // dateTime: DateTime.now(),
        // createdTime: DateTime.now()
      );

      DataBaseFunctionalty.saveNote(newNote);
    }

    log("after update");
  }

  Future deleteNode() async {
    await DataBaseFunctionalty.deleteNote(widget.note!.id);
  }
}
