import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/firebase/firebase_functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

double getMaxWidthMediaQuery(BuildContext context, [double? number]) {
  return MediaQuery.of(context).size.width * (number ?? 1);
}

double getMaxHieghtMediaQuery(BuildContext context, [double? number]) {
  return MediaQuery.of(context).size.height * (number ?? 1);
}

void emailValidator(String email) {
  if (email.isEmpty) {
    if (!userRegFormErrors.contains('Please enter an email!')) {
      userRegFormErrors.add('Please enter an email!');
    }
    if (!errorList.contains('Please enter an email!')) {
      errorList.add('Please enter an email!');
    }
  } else {
    userRegFormErrors.remove('Please enter an email!');
    if (!email.contains('@gmail.com')) {
      if (!userRegFormErrors.contains('Please check your email address!')) {
        userRegFormErrors.add('Please check your email address!');
      }
    } else if (email.contains('@gmail.com')) {
      userRegFormErrors.remove('Please check your email address!');
    }
    if (!errorList.contains('Please check your email address!')) {
      errorList.add('Please check your email address!');
    }
  }
}

void passwordValidator(String password) {
  if (password.isEmpty) {
    if (!userRegFormErrors.contains('Please enter your password!')) {
      userRegFormErrors.add('Please enter your password!');
    }
    if (!errorList.contains('Please enter your password!')) {
      errorList.add('Please enter your password!');
    }
  } else {
    userRegFormErrors.remove('Please enter your password!');
    if (password.length < 6) {
      if (!userRegFormErrors
          .contains('Password must be more than 6 characters!')) {
        userRegFormErrors.add('Password must be more than 6 characters!');
      }
    } else if (password.length == 6 || password.length > 6) {
      userRegFormErrors.remove('Password must be more than 6 characters!');
    }
    if (!errorList.contains('Password must be more than 6 characters!')) {
      errorList.add('Password must be more than 6 characters!');
    }
  }
}

Future<bool> checkEmailAvailability(
  String email,
  BuildContext context,
) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    final List<String> providers =
        await _auth.fetchSignInMethodsForEmail(email);
        print(providers);

    if (providers.isNotEmpty) {
      // Email already exists
      showSnackBar(
        context: context,
        text: 'Email already exists!',
        duration: 3,
      );
      return false;
    }
    return true;
  } catch (error) {
    showSnackBar(
        context: context,
        text: 'Error checking email availability: $error',
        duration: 4);

    return false;
  }
}

// to set condition lottie file
String getWeatherAnimations(String? mainCondition) {
  if (mainCondition == null) {
    return 'assets/images/weather_icons/sunny.json';
  }

  switch (mainCondition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/images/weather_icons/cloudy.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/images/weather_icons/rainy.json';
    case 'thunderstorm':
      return 'assets/images/weather_icons/thunder.json';
    case 'clear':
      return 'assets/images/weather_icons/sunny.json';
    default:
      return 'assets/images/weather_icons/sunny.json';
  }
}

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true; // User is connected to the internet
  } else {
    return false; // User is not connected to the internet
  }
}

void shareAppWithFriends(BuildContext context) {
  String shareText = '';
  shareText = 'Explore SPACE and NASA with this amazing app!!';
  Share.share(
    shareText,
    subject: 'Share app with friends',
    sharePositionOrigin:
        Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width, 100),
  );
}

// for redirecting to any social media account
void redirectToSocialMedia(
    {required String link, required BuildContext context}) async {
  Uri? socialMediaLink;

  socialMediaLink = Uri.parse(link);
  try {
    if (await canLaunchUrl(socialMediaLink)) {
      launchUrl(socialMediaLink);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Couldn\'t redirect!'),
      ),
    );
  }
}

// for sending mail
void mail({required String email}) async {
  Uri url = Uri(scheme: 'mailto', path: email);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "Something went wrong, please try again later!";
  }
}

// for making call
void call({required String phoneNumber}) async {
  Uri url = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "Something went wrong, please try again later!";
  }
}

//? home screen functions -----
//? home screen functions -----

//* news container fetch image function ...
// ---> refer to homescreen init() method

// get planets from firebase

//* dicover perfect images fetch function ...


//? home screen functions -----
//? home screen functions -----





// Future<List<ImageModel>> fetchImages(BuildContext context) async {
//   var url = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=5';
//   // try {
//   var response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     // '[{},{},{}]'
//     var fetchedImagesList = jsonDecode(response.body);
//     // [{},{},{}]
//     for (var x in fetchedImagesList) {
//       // {} = x ==> {x}
//       fetched.add(ImageModel.fromJson(x));
//       print(fetched[0].getHdurl());
//     }
//     await Future.delayed(Duration(seconds: 3));
//     if (fetched.length != 50) {
//       List<int> _int = List.generate(5, (i) => list.length + i + 1);
//       //API Calls
//       setState(() {
//         list.addAll(_int);
//         _isMoreData = false;
//       });
//     } else {
//       setState(() {
//         _isMoreData = true;
//       });
//     }
//   }
//   print('successfull');
//   return fetched;
//   // } catch (e) {
//   //   print(e);
//   // }
// }