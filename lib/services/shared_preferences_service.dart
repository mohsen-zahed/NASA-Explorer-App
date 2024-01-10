// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass {
  final String onBoardingScreenStatus = 'checked_onboarding';
  final String userLoginStatus = 'user_logged_in';
  final String userHomeFirstTimeStatus = 'home_screen_first_time';

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
}
