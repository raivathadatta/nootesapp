// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:googlesineintry/thems.dart';
import 'package:googlesineintry/widgets/show_error.dart';
import 'package:googlesineintry/widgets/textWidgert.dart';

import '../resorces/authentication.dart';
import '../resorces/auth_exceptions.dart';
import '../screens/home_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  bool _isObscure = true;

  final emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

  /////understand

  buildInputForm(String label, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }

  logIn() async {
    try {
      await AuthMethods.login(
          email: emailController.text, password: passwordController.text);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DisplatScreen()));
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
