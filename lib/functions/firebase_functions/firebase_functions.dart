// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';

class FirebaseFunctions {
  late FirebaseAuth _auth;
  FirebaseFunctions(this._auth);
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.message.toString(), duration: 2);
    }
  }

  Future<void> signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        // The email address is not properly formatted.
        showSnackBar(context: context, text: e.toString(), duration: 2);
      }
      if (e.code == 'user-not-found') {
        // The email address is not registered for any sign-in method.
        showSnackBar(context: context, text: e.toString(), duration: 2);
      }
      if (e.code == 'wrong-password') {
        // The email address is associated with a different sign-in method.
        showSnackBar(context: context, text: e.toString(), duration: 2);
      }
    }
  }

  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.message.toString(), duration: 3);
    }
  }

  Future<void> signOutUser({required BuildContext context}) async {
    try {
      await _auth.signOut();
      await SharedPreferencesClass()
          .saveLoginStatusToSharedPreferences(isLoggedIn: false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.message.toString(), duration: 4);
    }
  }
}
