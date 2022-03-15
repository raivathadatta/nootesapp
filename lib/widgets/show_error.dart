import 'package:flutter/material.dart';

import '../screens/login_scree.dart';

class ShowError {
  static showError(String e, BuildContext context) {
    // ignore: dead_code
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error Message"),
            content: Text(e),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  static popUp(String s, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("User Sign Up Succfullf "),
            content: Text(s),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginIn()),
                      ),
                  child: const Text("Ok")),
            ],
          );
        });
  }
}
