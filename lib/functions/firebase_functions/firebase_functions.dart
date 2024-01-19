// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFunctions();
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      );
      var date = DateTime.now().toString();
      var dateStamp = DateTime.parse(date);
      var formattedDate =
          '${dateStamp.day}-${dateStamp.month}-${dateStamp.year}-${dateStamp.hour}-${dateStamp.minute}';
      final User? user = _auth.currentUser;
      final uid = user?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'emailAddress': email,
        'password': password,
        'imageUrl': demoProfileImageHolder,
        'joinedAt': formattedDate,
        'createdAt': Timestamp.now(),
      });
      userRegFormErrors.clear();
      errorList.clear();
    } on FirebaseAuthException catch (e) {
      if (email.isNotEmpty) {
        if (!userRegFormErrors.contains(e.message.toString())) {
          userRegFormErrors.add(e.message.toString());
        }
        if (!errorList.contains(e.message.toString())) {
          errorList.add(e.message.toString());
        }
      }
      // showSnackBar(context: context, text: e.message.toString(), duration: 4);
    }
  }

  Future<void> signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password.trim());
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

  Future<List<String>> getDocumentIds(
      {required String collectionName, required BuildContext context}) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await collectionReference.get();

      List<String> documentIds = querySnapshot.docs
          .map((DocumentSnapshot document) => document.id)
          .toList();
      return documentIds;
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString(), duration: 4);
      return [];
    }
  }
}
