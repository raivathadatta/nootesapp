// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlesineintry/models/note.dart';

import 'package:googlesineintry/thems.dart';

import '../../resorces/commonfunctions.dart';

import 'create_update_note.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // get textEditingController => null;
  // List<int> searchResultIDs = [];
  List<Note?> searchResultNotes = [];
  List<Note> notesList = [];

  bool isLoading = false;

  int get limit => 20;

  @override
  void initState() {
    searchResultNotes.clear();
    super.initState();
    isLoading = true;
    DataBaseFunctionalty.getAllNodes(limit).then((value) {
      setState(() {
        notesList = value;
        isLoading = false;
      });
    });
  }

  void searchResults(String searchValue) async {
    searchResultNotes.clear();
    log(searchResultNotes.length.toString() + "////////////////////");
    log(searchValue.toString());
    if (searchValue != "") {
      notesList.forEach((item) {
        if (item.title!.contains(searchValue) ||
            item.content.contains(searchValue)) {
          searchResultNotes.add(item);
          log(searchResultNotes.length.toString() + "hhhhhhhhhhhhhhh");
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            decoration: BoxDecoration(color: white.withOpacity(0.1)),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_outlined),
                      color: white,
                    ),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search Your Notes",
                          hintStyle: TextStyle(
                              color: white.withOpacity(0.5), fontSize: 16),
                        ),
                        onChanged: (value) {
                          searchResults(value.toLowerCase().trim());
                          // log(value);
                        },
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        child: NoteSectionAll(),
                      )
              ],
            ),
          )),
        ));
  }
  //////////////////////////////////////

  Widget NoteSectionAll() {
    return Container(
      child: Column(
        children: [
          StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchResultNotes.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateUpdateNote(
                                  note: searchResultNotes[index]!)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(searchResultNotes[index]!.title!,
                              style: const TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            searchResultNotes[index]!.content.length > 250
                                ? "${searchResultNotes[index]!.content.substring(0, 250)}..."
                                : searchResultNotes[index]!.content,
                            style: const TextStyle(color: white),
                          )
                        ],
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
