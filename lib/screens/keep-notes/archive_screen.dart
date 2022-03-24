// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googlesineintry/models/note.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/resorces/local_data_bace.dart';
import 'package:googlesineintry/screens/keep-notes/createnotes_view.dart';
import 'package:googlesineintry/screens/keep-notes/searchview_screen.dart';
import 'package:googlesineintry/widgets/keetnotes/sidebar_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlesineintry/thems.dart';

import '../../widgets/keetnotes/textcontainer.dart';

// import '../models/note_model.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  bool isLoading = false;
  List<Note> notesList = [];
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  static bool isView = false;

  @override
  void initState() {
    super.initState();

    getAllNotes();

    // getAllNotesDATABACE();
  }

  /////////////////////notable to add pinn and archive

  Future createEntry(Note note) async {
    await NotesDatabase.instance.InsertEntry(note);
  }

  Future getAllNotesDATABACE() async {
    List<Note> newl = await AuthMethods.getAllNotesFromFireStore();
    log('////////////////////////////////////////');
    log(newl.length.toString());
    setState(() {
      notesList = newl;
    });
  }

  Future getAllNotes() async {
    List<Note> archivelist = await NotesDatabase.instance.readAllNotes();
    archivelist.forEach((element) {
      if (element.isArchieve) {
        notesList.add(element);
      }
    });
  }

  Future findNodeById(int id) async {
    await NotesDatabase.instance.findNoteById(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabase.instance.updateNote(note);
  }

  Future deleteNote(Note note) async {
    if (note.id != null) {
      await NotesDatabase.instance.delteNote(note.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(
                child: CircularProgressIndicator(
              color: white,
            )),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: const Icon(
                Icons.add,
                size: 45,
              ),
            ),
            key: drawerKey,
            endDrawerEnableOpenDragGesture: true,
            backgroundColor: bgColor,
            drawer: const SideBar(),
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  setState(() {});
                });
              },
              child: SafeArea(
                  child: Column(
                children: [
                  searchBar(),
                  // listSectionAll(),

                  Expanded(child: !isView ? listSectionAll() : noteSectionAll())
                ],
              )),
            ));
  }

///////////////////////////////////////////////////////////////////////////////////////////////
  noteSectionAll() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: StaggeredGridView.countBuilder(
          // controller: ,
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notesList.length,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          crossAxisCount: 4,
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
          itemBuilder: (context, index) => TextContainer(
                heading: notesList[index].title!,
                index: index,
                note: notesList[index].content,
                noteData: notesList[index],
              )),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  listSectionAll() {
    return ListView.builder(
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) {
        return TextContainer(
          heading: notesList[index].title!,
          index: index,
          note: notesList[index].content,
          noteData: notesList[index],
        );
      },
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  searchBar() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
          height: 55,
          decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 3),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => drawerKey.currentState!
                          .openDrawer(), //.currentState!.openDrawer();
                      //
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white.withOpacity(0.3),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchView()));
                    }),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Search or notes",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      height: 65,
                      width: 190,
                    ),
                  )
                ],
              ),

              ///row 2
              ///
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          /////////////////////////////////////add hear
                          setState(() {
                            isView = !isView ? true : false;
                          });
                        }, //add  code

                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                            )),
                        child: isView
                            ? const Icon(
                                Icons.grid_view,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.list_alt,
                                color: white,
                              )),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
              )
            ],
          ),
        )
      ], //flutter sear bar
    );
  }
}
