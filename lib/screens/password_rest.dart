// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:googlesineintry/resorces/authentication.dart';
// import 'package:googlesineintry/screens/loginscree.dart';
import 'package:googlesineintry/widgets/textWidgert.dart';

import 'login_scree.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFeldInput(
            hint: 'EnterEmail',
            icon: const Icon(
              Icons.mail,
              color: Colors.black,
            ),
            ispass: false,
            textEditingController: emailController,
            type: TextInputType.emailAddress,
          ),
          RaisedButton(
            onPressed: reset,
            child: const Text("rest password"),
          ),
          GestureDetector(
            child: const Text(
              'to Main Screen',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginIn()),
              );
            },
          ), //
        ],
      ),
    );
  }

  void reset() async {
    try {
      await AuthMethods.resetPassword(emailController.text, context);

      Navigator.pop(context);

      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => const LoginIn()));
      // }
    } catch (err) {
      showError(err.toString(), true);
    }
  }

  void showError(String e, bool state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error Message"),
            content: Text(e),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
