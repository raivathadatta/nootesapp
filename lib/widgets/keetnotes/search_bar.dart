import 'package:flutter/material.dart';

// import 'package:googlesineintry/resorces/Authentication.dart';
import 'package:googlesineintry/resorces/authentication.dart';

import '../../screens/keep-notes/search_screen.dart';
import '../../thems.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => const SearchScreen()));
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
                          //  AuthMethods.checkStateGrid();
                        }, //add  code

                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                            )),
                        child: const Icon(
                          Icons.grid_view,
                          color: Colors.white,
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
