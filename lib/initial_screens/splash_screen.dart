import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/initial_screens/onboarding_screen.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void fetchImages() async {
    // try {
    var imagesResponse = await http.get(Uri.parse(imagesUrl));
    if (imagesResponse.statusCode == 200) {
      var imagesList = jsonDecode(imagesResponse.body);
      for (var x in imagesList) {
        if (x['media_type'] == 'image') {
          fetchedImagesList.add(ImageModel.fromJson(x));
        } else {
          continue;
        }
      }
      List<String> demoHomeImagesList = [];
      for (var i = 0; i < 5; i++) {
        demoHomeImagesList.add(fetchedImagesList[i].getUrl());
      }
      if (mounted) {
        setState(() {
          homeImagesList = demoHomeImagesList;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () async {
        isUserConnected = await checkInternetConnectivity();
        fetchImages();
        if (isUserConnected) print('connection available');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
            (route) => false);
      },
    );
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
