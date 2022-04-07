// ignore_for_file: deprecated_member_use, dead_code_on_catch_subtype

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesineintry/models/model.dart';

import 'package:googlesineintry/widgets/show_error.dart';

import '../screens/login-signup/login_scree.dart';
import 'auth_exceptions.dart';

class AuthMethods {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const storage = FlutterSecureStorage();
  static final googleSignIn = GoogleSignIn();
  static late final UserCredential cred;

  static late String forwardEMail;

  static signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        log("person" + "email");
        final person = Person(
            firstName: firstname,
            phone: phone,
            lastName: lastname,
            email: email,
            uid: cred.user!.uid,
            password: password);

        final jsgon = {
          'firstName': person.firstName,
          'phone': person.phone,
          'lastName': person.lastName,
          'email': person.email,
          'uid': cred.user!.uid,
          'password': person.password
        };
        log(person.email);

        forwardEMail = person.email;
        await users
            .doc(cred.user!.uid)
            .set(jsgon)
            .then((value) => log(" Succfull"));
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///login user

  static login({required String email, required String password}) async {
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
    await _auth.sendPasswordResetEmail(email: email);
  }
}
