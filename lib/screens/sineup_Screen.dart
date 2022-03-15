// ignore_for_file: deprecated_member_use

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:googlesineintry/thems.dart';
import '../widgets/signup_form.dart';
import 'login_scree.dart';
// import 'loginscree.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 70,
      ),
      Padding(
        padding: kDefaultPadding,
        child: Text(
          'Create Account',
          style: titleText,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: kDefaultPadding,
        child: Row(
          children: [
            Text(
              'Already a member?',
              style: subTitle,
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginIn()));
              },
              child: Text(
                'Log In',
                style: textButton.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            )
          ],
        ),
      ),

      // padding: const EdgeInsets.all(8.0),

      const SizedBox(
        height: 10,
      ),

      const Padding(
        padding: kDefaultPadding,
        child: SignUpForm(),
      ),
      const SizedBox(
        height: 20,
      ),
    ])));
  }
}
