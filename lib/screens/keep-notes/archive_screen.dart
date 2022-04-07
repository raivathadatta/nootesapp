// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googlesineintry/models/note.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/resorces/firebase_storage.dart';
import 'package:googlesineintry/resorces/local_data_bace.dart';
import 'package:googlesineintry/screens/home_screen.dart';
import 'package:googlesineintry/screens/keep-notes/create_update_note.dart';
// import 'package:googlesineintry/screens/keep-notes/create_note.dart';
import 'package:googlesineintry/screens/keep-notes/search_screen.dart';
import 'package:googlesineintry/widgets/keetnotes/sidebar_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlesineintry/thems.dart';

import '../../widgets/keetnotes/gridview_creator.dart';
import '../../widgets/keetnotes/note_cell.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  bool loaded = false;
  List<Note> archiveList = [];
  bool isGridView = isTrue;

  final ScrollController _scrollController = ScrollController();

  // static bool isView = false;

  @override
  void initState() {
    super.initState();

    getArchiveList();
    log("in gggggg end");
  }

  void getArchiveList() async {
    archiveList = await FireBaseStorage().getArchiveList();
    log(archiveList.length.toString() + "-------------------");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(
                child: CircularProgressIndicator(
              color: white,
            )),
          )
        : Scaffold(
            backgroundColor: bgColor,
            appBar: searchBar(),
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 0), () {
                  setState(() {});
                });
              },
              child: SafeArea(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(child: noteDisplay(archiveList))
                ],
              )),
            ));
  }

//note grid view
  noteDisplay(archiveList) {
    log(archiveList.length.toString() + "list length");

    return GridViewCreater(
      scrollController: _scrollController,
      isGridView: true,
      list: archiveList,
    );
  }

  searchBar() {
    return AppBar(
      backgroundColor: bgColor,
      leading: IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen())), //.currentState!.openDrawer();
          //
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white.withOpacity(0.3),
          )),
      title: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
          child: const Text(
            "Search or note",
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            }, //add  code

            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.white.withOpacity(0.1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                )),
            child: isGridView
                ? const Icon(
                    Icons.grid_view,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.list_alt,
                    color: white,
                  )),
        const SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
