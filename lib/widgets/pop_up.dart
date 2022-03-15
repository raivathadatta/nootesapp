// ignore_for_file: unnecessary_new, deprecated_member_use

import 'package:flutter/material.dart';

import '../screens/login_scree.dart';

// import '../screens/loginscree.dart';

class POpUp extends StatelessWidget {
  const POpUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Hello"),
        ],
      ),
      actions: [
        new FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginIn()),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
