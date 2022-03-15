// ignore_for_file: deprecated_member_use

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlesineintry/resorces/authentication.dart';
import 'package:googlesineintry/resorces/auth_exceptions.dart';
// import 'package:googlesineintry/widgets/pop_up.dart';
import 'package:googlesineintry/widgets/show_error.dart';
import 'package:googlesineintry/widgets/textWidgert.dart';

// import '../screens/loginscree.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final namecontroller = TextEditingController();
  final _password = TextEditingController();
  final _mail = TextEditingController();

  final _phoneNumber = TextEditingController();

  var lastnamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Enter the reqired details",
            style: TextStyle(color: Colors.redAccent, fontSize: 20),
          ),

          ///name
          const SizedBox(
            height: 30,
          ),
          TextFeldInput(
            textEditingController: namecontroller,
            hint: "Enter FirstName",
            ispass: false,
            type: TextInputType.name,
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //lastname

          TextFeldInput(
            textEditingController: lastnamecontroller,
            hint: "Enter lastName",
            ispass: false,
            type: TextInputType.name,
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //phonenumber
          TextFeldInput(
            textEditingController: _phoneNumber,
            hint: "Enter PhoneNumber",
            ispass: false,
            type: TextInputType.phone,
            icon: const Icon(
              Icons.phone,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // //mail
          TextFeldInput(
            textEditingController: _mail,
            hint: "Enter Email",
            ispass: false,
            type: TextInputType.emailAddress,
            icon: const Icon(
              Icons.mail,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //password
          TextFeldInput(
            textEditingController: _password,
            hint: "Enter Password",
            ispass: false,
            type: TextInputType.emailAddress,
            icon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              padding: const EdgeInsets.fromLTRB(70, 10, 70, 10),
              child: const Text('SignUp',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: signUP,
            ),
          ),
          const SizedBox(
            height: 250,
          )
        ]);
  }

  signUP() async {
    try {
      ShowError.showError("succfull", context);
      await AuthMethods.signUp(
        email: _mail.text,
        password: _password.text,
        firstname: namecontroller.text,
        lastname: lastnamecontroller.text,
        phone: _phoneNumber.text,
      );
      ShowError.popUp("Week Password", context);
    } on WeakPasswordAuthException catch (_) {
      ShowError.showError("Week Password", context);
    } on EmailAlreadyInUseAuthException catch (_) {
      ShowError.showError("This Email Used Is already in Use", context);
    } on InvalidEmailAuthException catch (_) {
      ShowError.showError("this EMAIL IS IN VALIED", context);
    } on GenericAuthException catch (_) {
      ShowError.showError("SOME THING WENT WRONG", context);
    } catch (err) {
      ShowError.showError(err.toString(), context);
    }
  }
}
