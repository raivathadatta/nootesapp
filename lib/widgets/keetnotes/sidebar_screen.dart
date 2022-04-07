// ignore_for_file: avoid_returning_null_for_void

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/Authentication.dart';
import 'package:googlesineintry/screens/keep-notes/archive_screen.dart';
import 'package:googlesineintry/screens/keep-notes/setting_screen.dart';
import 'package:googlesineintry/thems.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: bgColor,
      child: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Archive'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ArchiveScreen(),
                  ),
                );
              }, //////////
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Archive'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArchiveScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Log-out/Exit'),
              onTap: () => AuthMethods.signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
