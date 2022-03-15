// ignore_for_file: deprecated_member_use, unused_element, unused_local_variable

import 'package:flutter/material.dart';

import 'package:googlesineintry/screens/password_rest.dart';
import 'package:googlesineintry/screens/sineup_Screen.dart';

import '../thems.dart';
import '../widgets/login_goole.dart';
import '../widgets/loginin_form.dart';

///loginscreen
class LoginIn extends StatefulWidget {
  const LoginIn({Key? key}) : super(key: key);
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  // Future<UserCredential>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Container(
                height: 150,
                margin: const EdgeInsets.all(22),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(22),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://media.istockphoto.com/vectors/lock-icon-vector-id936681148'),
                  ),
                )), ////add an lock image
            const SizedBox(
              height: 20,
            ),

            Text("Welcome to App", style: titleText),
            const SizedBox(
              height: 5,
            ),
            Row(children: [
              Text(
                'New to this app?',
                style: subTitle,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: textButton.copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 12,
            ),

            const SizedBox(
              height: 12,
            ),

            const LoginForm(),

            const SizedBox(
              height: 8,
            ),
            //forgetpassword

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordReset()));
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: kZambeziColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            //login with gmail
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LoginInGoole(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
