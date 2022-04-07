// ignore_for_file: deprecated_member_use, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/auth_exceptions.dart';

import 'package:googlesineintry/screens/login-signup/password_rest.dart';
import 'package:googlesineintry/screens/login-signup/sineup_Screen.dart';

import '../../resorces/Authentication.dart';
import '../../thems.dart';
import '../../widgets/login-signup/login_goole.dart';

import '../../widgets/show_error.dart';
import '../../widgets/login-signup/textfeldInput.dart';
import '../home_screen.dart';

///loginscreen
class LoginIn extends StatefulWidget {
  const LoginIn({Key? key}) : super(key: key);
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  final emailController = TextEditingController();

  var passwordController = TextEditingController();

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

            loginForm(),
            const SizedBox(
              height: 8,
            ),

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

  loginForm() {
    //////////
    return Column(children: [
      TextFeldInput(
        hint: 'EnterEmail',
        icon: const Icon(
          Icons.mail,
          color: kTextFieldColor,
        ),
        ispass: false,
        textEditingController: emailController,
        type: TextInputType.emailAddress,
      ),
      const SizedBox(
        height: 12,
      ),
      TextFeldInput(
        hint: 'Enter PassWord',
        icon: const Icon(
          Icons.lock,
          color: kTextFieldColor,
        ),
        ispass: true,
        textEditingController: passwordController,
        type: TextInputType.emailAddress,
      ),
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: RaisedButton(
          onPressed: logIn,
          elevation: 0.0,
          child: const Text(
            "Login",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          // padding: const EdgeInsets.symmetric(vertical: 20),

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.grey,
        ),
      ),
    ]);
  }

  logIn() async {
    try {
      await AuthMethods.login(
          email: emailController.text, password: passwordController.text);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      // ignore: nullable_type_in_catch_clause
    } on UserNotFoundException catch (_) {
      ShowError.showError("invalid user", context);
    } on WrongPasswordAuthException catch (_) {
      ShowError.showError("Invalied Credenction", context);
    } on GenericAuthException catch (_) {
      ShowError.showError("Some thing Went Wrong", context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
