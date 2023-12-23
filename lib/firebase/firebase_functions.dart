import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';

class FirebaseFunctions {
  late FirebaseAuth _auth;
  FirebaseFunctions(this._auth);
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: e.toString(), duration: 2);
      print(e.toString());
    }
  }

  Future<void> signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, text: 'fasdfsda', duration: 2);
    }
  }
}
