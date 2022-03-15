import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesineintry/widgets/show_error.dart';

import '../screens/home_screen.dart';

class LoginInGoole extends StatefulWidget {
  const LoginInGoole({Key? key}) : super(key: key);

  @override
  State<LoginInGoole> createState() => _LoginInGooleState();
}

class _LoginInGooleState extends State<LoginInGoole> {
  static const storage = FlutterSecureStorage();
  //google sine in method
  Future googleSignIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        // ShowError.showError(user.toString(), context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplatScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ShowError.showError(e.toString(), context);
        } else if (e.code == 'invalid-credential') {
          ShowError.showError(e.toString(), context);
        }
      } catch (e) {
        ShowError.showError(e.toString(), context);
      }
    }
    // debugPrint("in print");
    // GoogleSignIn googleSignIn = GoogleSignIn();

    // GoogleSignInAccount? User = await googleSignIn.signIn();
    // // debugPrint("in");

    // if (User != null) {
    //   GoogleSignInAuthentication googleAuth = await User.authentication;

    //   if (googleAuth.accessToken != null) {
    //     final AuthCredential credential = GoogleAuthProvider.credential(
    //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //     var _auth = FirebaseAuth.instance;
    //     try {
    //       final UserCredential user =
    //           await _auth.signInWithCredential(credential);
    //       await storage.write(key: 'uid', value: user.user?.uid);

    //     } catch (e) {
    //       ShowError.showError(e.toString(), context);
    //     }
    //     // return user;
    //   } else {
    //     ShowError.showError('Missing Google Auth Token', context);
    //   }
    // } else {
    //   ShowError.showError('Sign in Aborted', context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      //  mainAxisAlignment: MainAxisAlignment.center,
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.56,
      // color: Colors.grey,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Colors.grey.shade300)),
      child: ElevatedButton(
        onPressed: googleSignIn,
        child: const Text("Sign in with google"),
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
        ),
      ),
    );
  }
}
