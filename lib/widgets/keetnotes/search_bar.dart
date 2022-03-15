import 'package:flutter/material.dart';

// import 'package:googlesineintry/resorces/Authentication.dart';
import 'package:googlesineintry/resorces/authentication.dart';

import '../../thems.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // static final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
          // width: MediaQuery.of(context).size.width,
          // width: 300,
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
                      onPressed: () =>
                          AuthMethods.drawerKey.currentState!.openDrawer(), //
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white.withOpacity(0.3),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
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
                    height: 55,
                    width: 190,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
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
                        onPressed: () {}, //add  code

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
