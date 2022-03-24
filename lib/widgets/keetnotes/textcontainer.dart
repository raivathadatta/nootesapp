import 'package:flutter/material.dart';
import 'package:googlesineintry/screens/keep-notes/note_screen.dart';

import '../../models/note.dart';

class TextContainer extends StatelessWidget {
  final String heading;
  final String note;

  final int index;

  Note noteData;

  TextContainer(
      {Key? key,
      required this.heading,
      required this.note,
      required this.index,
      required this.noteData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteView(
                      note: noteData,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.length > 250 ? "${note.substring(0, 250)}..." : note,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    ); //
  }
}



////
///
///
