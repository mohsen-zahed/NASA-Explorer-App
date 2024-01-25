// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  final String onBoardingScreenStatus = 'checked_onboarding';
  final String userLoginStatus = 'user_logged_in';
  final String userHomeFirstTimeStatus = 'home_screen_first_time';
  final String generatedIds = 'generated_ids';

  // save api req for home screen
  Future<bool> saveUserVisitHomeStatus({required bool alreadyVisited}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return await _sharedPreferences.setBool(
        userHomeFirstTimeStatus, alreadyVisited);
  }

  // get api req for home screen
  Future<bool?> getUserVisitHomeStatus() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(userHomeFirstTimeStatus);
  }

  // function for saving status
  Future<bool> saveOnboardingStatusToSharedPreferences(
      {required bool isLoggedIn}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return await _sharedPreferences.setBool(onBoardingScreenStatus, isLoggedIn);
  }

  // function for fetching status
  Future<bool?> getOnboardingStatusFromSharedPreferences() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(onBoardingScreenStatus);
  }

  // function for saving login status
  Future<bool> saveLoginStatusToSharedPreferences(
      {required bool isLoggedIn}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return await _sharedPreferences.setBool(userLoginStatus, isLoggedIn);
  }

  // function for fetching login status
  Future<bool?> getLoginStatusFromSharedPreferences() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(userLoginStatus);
  }

  // function for saving random generated ids
  Future<bool> saveGeneratedIdsToSharedPreferences(
      {required List<int>? generatedIdsList, required String key}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String listAsString = generatedIds;
    return await _sharedPreferences.setString(
      key,
      jsonEncode(listAsString),
    );
  }

  // function for fetching random generated ids
  Future<List<int>?> getGeneratedIdsFromSharedPreferences(
      {required String key}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String? x = _sharedPreferences.getString(key);

    return jsonDecode(x!);
  }

  // function for saving last random generated id
  Future<bool> saveLastGeneratedIdToSharedPreferences(
      {required int lastId, required String key}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return await _sharedPreferences.setInt(key, lastId);
  }

  // function for fetching last random generated id
  Future<int?> getLastGeneratedIdFromSharedPreferences(
      {required String key}) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(key);
  }
}
