import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googlesineintry/models/note.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/resorces/local_data_bace.dart';
import 'package:googlesineintry/thems.dart';

import '../../resorces/commonfunctions.dart';
import '../home_screen.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key}) : super(key: key);

  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          Container(
            child: IconButton(
                onPressed: () {
                  _saveData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          IconButton(
              splashRadius: 17,
              onPressed: () {},
              icon: const Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextField(
              cursorColor: white,
              controller: titlecontroller,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 300,
              child: TextField(
                cursorColor: white,
                controller: contentController,
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
            )
          ],
        ),
      ),
    );
  }

  _saveData() async {
    log("hello");

    final newNote = Note(
        pin: false,
        title: titlecontroller.text,
        content: contentController.text,
        // createdTime: DateTime.now(),
        isArchieve: false,
        id: "");

    DataBaseFunctionalty.saveNote(newNote);
    log("oin save data");

    // AuthMethods.saveNote(newNote);
  }
}
