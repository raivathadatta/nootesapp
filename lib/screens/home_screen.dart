// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_element

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/resorces/notification_managers.dart';
// import 'package:googlesineintry/screens/keep-notes/create_note.dart';
import 'package:googlesineintry/widgets/keetnotes/sidebar_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlesineintry/thems.dart';

import '../models/note.dart';

import '../resorces/firebase_storage.dart';
import '../resorces/local_data_bace.dart';
import '../widgets/keetnotes/gridview_creator.dart';
import '../widgets/keetnotes/search_bar.dart';

import '../widgets/keetnotes/note_cell.dart';
import 'keep-notes/create_update_note.dart';
import 'keep-notes/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loaded = false;

  List<Note> pinList = []; //////////pinList
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  bool isGridView = isTrue;

  List<Note> listpagination = [];
  bool allLoaded = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    NotificationManager().createNotification();
    super.initState();
    setState(() {
      loaded = true;
    });
    getAllNotesPagination();
    setState(() {
      loaded = false;
    });
    //  inislizing the notifications
    _scrollController.addListener(() {
      log("in more list");
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loaded) {
        getmoreList();
        log("in more list end");
      }
    });
  }

  Future getmoreList() async {
    if (allLoaded) {
      return;
    }
    try {
      List<Note> newList = await FireBaseStorage().getMoreNotesFromFB();
      log(newList.length.toString() + "llllllllllllllllllllll");
      if (newList.length < 10) {
        allLoaded = true;
        // loaded = true;
      }
      listpagination.addAll(newList);
      log(listpagination.length.toString() + "kkkkkk");
      setState(() {});
    } catch (e) {
      if (e.toString() == "theendlist") {
        allLoaded = true;
      }
    }
  }

  Future getAllNotesPagination() async {
    List<Note> newList = await FireBaseStorage().getAllNotesPagination();
    if (newList.length < 10) {
      allLoaded = true;
    }
    setState(() {
      listpagination = newList;
    });
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateUpdateNote()));
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
                  Expanded(child: noteDisplay(listpagination))
                ],
              )),
            ));
  }

//note grid view
  noteDisplay(List<Note> list) {
    log(list.length.toString() + "list length");

    return GridViewCreater(
      scrollController: _scrollController,
      isGridView: isGridView,
      list: list,
    );
  }

// search bar///////////////////
  searchBar() {
    return AppBar(
      backgroundColor: bgColor,
      leading: IconButton(
          onPressed: () => drawerKey.currentState!
              .openDrawer(), //.currentState!.openDrawer();
          //
          icon: Icon(
            Icons.menu,
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
