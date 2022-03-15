// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/screens/side_bar.dart';

import 'package:googlesineintry/thems.dart';

import '../widgets/keetnotes/search_bar.dart';

class DisplatScreen extends StatefulWidget {
  const DisplatScreen({Key? key}) : super(key: key);

  @override
  _DisplatScreenState createState() => _DisplatScreenState();
}

class _DisplatScreenState extends State<DisplatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AuthMethods.drawerKey,
      endDrawerEnableOpenDragGesture: true,
      backgroundColor: bgColor,
      drawer: const SideBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const SearchBar(),
        ],
      ),
    );
  }
}
