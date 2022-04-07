import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/note.dart';
import '../../screens/keep-notes/create_update_note.dart';
import '../../thems.dart';
import 'note_cell.dart';

class GridViewCreater extends StatelessWidget {
  const GridViewCreater({
    Key? key,
    required ScrollController scrollController,
    required this.isGridView,
    required this.list,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final bool isGridView;
  final List<Note> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: list.length, ///////////////////////////////
          mainAxisSpacing: mainAxixAlinementSpaceing, //dont make it constant
          crossAxisSpacing: crossAxisAlignmentSpacing,
          crossAxisCount: crossAxisCountnumber,
          staggeredTileBuilder: (index) =>
              StaggeredTile.fit(isGridView ? 1 : 2),
          itemBuilder: (context, index) {
            log(index.toString() + " " + list.length.toString());

            if (index < list.length) {
              return NoteCell(
                  note: list[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUpdateNote(
                                  note: list[index],
                                )));
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
