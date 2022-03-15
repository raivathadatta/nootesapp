// ignore_for_file: deprecated_member_use, dead_code_on_catch_subtype

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesineintry/widgets/show_error.dart';
// import '../screens/loginscree.dart';
import '../screens/login_scree.dart';

import 'auth_exceptions.dart';

class AuthMethods {
  static GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const storage = FlutterSecureStorage();
  static final googleSignIn = GoogleSignIn();

  // static var _drawerKey;

  static signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
    // required Uint8List file,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // model.User newUser = model.User(firstname, phone, lastname, email);
        // UserCredential personData =
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'firstname': firstname,
          'lastname': lastname,
          'phone': phone,
          'uid': cred.user!.uid,
          'email': email,
          'password': password
        });

        // log(_firestore.)
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///login user
  ///
  ///
  static login({required String email, required String password}) async {
    bool res = false;
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await storage.write(key: 'uid', value: user.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  static signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      storage.delete(key: 'uid');
      googleSignIn.signOut();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginIn()));
    } catch (err) {
      ShowError.showError(err.toString(), context);
    }
  }

  static resetPassword(String email, BuildContext context) async {
    // bool res = false;
    await _auth.sendPasswordResetEmail(email: email);
    // res = true;
  }
}
