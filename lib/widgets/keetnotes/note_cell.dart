import 'package:flutter/material.dart';
import 'package:googlesineintry/screens/keep-notes/create_update_note.dart';

import '../../models/note.dart';

class NoteCell extends StatelessWidget {
  //

  final Note note;
  final Function onTap;

  NoteCell({Key? key, required this.note, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.content.length > 250
                  ? "${note.content.substring(0, 250)}..."
                  : note.content,
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
