// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/initial_screens/onboarding_screen/onboarding_screen.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/main_home_screen.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => redirectToNextScreen(),
    );
  }

  Future<void> redirectToNextScreen() async {
    isUserConnected = await checkInternetConnectivity(context);

    // await checkRegistrationStatus(context);

    checkOnboardingScreen();
  }

  checkOnboardingScreen() async {
    if (await SharedPreferencesClass()
                .getOnboardingStatusFromSharedPreferences() ==
            null ||
        await SharedPreferencesClass()
                .getOnboardingStatusFromSharedPreferences() ==
            false) {
      isFirstTime = true;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
          (route) => false);
    }
    if (await SharedPreferencesClass().getLoginStatusFromSharedPreferences() ==
            null ||
        await SharedPreferencesClass().getLoginStatusFromSharedPreferences() ==
            false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainHomeScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg0.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                width: 280,
                height: 280,
                child: Hero(
                  tag: 'NASA Logo',
                  child: Image.asset(
                    'assets/images/nasa_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Explore The Galaxy!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kWhiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
