// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/home_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/suspended_main_home.dart';
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
    if (!userRegFormErrors.contains('Email field is required!')) {
      userRegFormErrors.add('Email field is required!');
    }
    if (!errorList.contains('Email field is required!')) {
      errorList.add('Email field is required!');
    }
  } else {
    userRegFormErrors.remove('Email field is required!');
    errorList.remove('Email field is required!');
    if (!email.contains('@gmail.com')) {
      if (!userRegFormErrors.contains('Email address is badly formatted!')) {
        userRegFormErrors.add('Email address is badly formatted!');
      }
      if (!errorList.contains('Email address is badly formatted!')) {
        errorList.add('Email address is badly formatted!');
      }
    } else {
      userRegFormErrors.remove('Email address is badly formatted!');
      errorList.remove('Email address is badly formatted!');
    }
  }
}

void passwordValidator(
    {required String password,
    required bool confirmPassword,
    String? password2}) {
  if (password.isEmpty) {
    if (!userRegFormErrors.contains('Password field is required!')) {
      userRegFormErrors.add('Password field is required!');
    }
    if (!errorList.contains('Password field is required!')) {
      errorList.add('Password field is required!');
    }
  } else {
    userRegFormErrors.remove('Password field is required!');
    errorList.remove('Password field is required!');
    if (password.length < 6) {
      if (!userRegFormErrors
          .contains('Password must be more than 6 characters!')) {
        userRegFormErrors.add('Password must be more than 6 characters!');
      }
      if (!errorList.contains('Password must be more than 6 characters!')) {
        errorList.add('Password must be more than 6 characters!');
      }
    } else if (password.length == 6 || password.length > 6) {
      if (userRegFormErrors
          .contains('Password must be more than 6 characters!')) {
        userRegFormErrors.remove('Password must be more than 6 characters!');
      }
      if (errorList.contains('Password must be more than 6 characters!')) {
        errorList.add('Password must be more than 6 characters!');
      }
    }
    if (confirmPassword) {
      if (password != password2) {
        if (!userRegFormErrors.contains('Please confirm your password!')) {
          userRegFormErrors.add('Please confirm your password!');
        }
        if (!errorList.contains('Please confirm your password!')) {
          errorList.add('Please confirm your password!');
        }
      } else {
        if (userRegFormErrors.contains('Please confirm your password!')) {
          userRegFormErrors.remove('Please confirm your password!');
        }
        if (errorList.contains('Please confirm your password!')) {
          errorList.remove('Please confirm your password!');
        }
      }
    }
  }
}

Future<bool> confirmPasswordShowStatus(
    String password, String confirmPassword) async {
  if (password == confirmPassword) {
    return true;
  } else {
    return false;
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

Future<bool> checkInternetConnectivity(BuildContext context) async {
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
    showSnackBar(context: context, text: 'Couldn\'t redirect!', duration: 3);
  }
}

// for redirecting to Ad's url target
void redirectToAdUrl(
    {required String link, required BuildContext context}) async {
  Uri? adUrl;

  adUrl = Uri.parse(link);
  try {
    if (await canLaunchUrl(adUrl)) {
      launchUrl(adUrl);
    }
  } catch (e) {
    showSnackBar(context: context, text: 'Couldn\'t redirect!', duration: 3);
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

Future<void> checkRegistrationStatus(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({'isRegistered': false});
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    bool isRegistered = userDoc.get('isRegistered');

    if (isRegistered) {
      // User is registered, navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } else {
      // User is not registered, navigate to registration screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(),
        ),
        (route) => false,
      );
    }
  } else {
    showSnackBar(context: context, text: 'user not found', duration: 3);
  }
}

AppBar customAppWidget({required String text}) {
  return AppBar(
    title: Text(text),
  );
}

String joinWords({required String text, int? end}) {
  List<String> _words = text.split(' ');
  String _extractedWord =
      _words.sublist(0, _words.length == 1 ? 1 : end ?? 2).join(' ');
  return _extractedWord;
}

String getDate() {
  String postedDay = DateTime.now().day.toString();
  String postedMonth = DateTime.now().month.toString();
  String postedYear = DateTime.now().year.toString();
  String postedTimeHour = DateTime.now().hour.toString();
  String postedTimeMinute = DateTime.now().minute.toString();
  String postedTimeZone =
      (int.parse(postedTimeHour) < 12 && int.parse(postedTimeHour) >= 1)
          ? 'AM'
          : (int.parse(postedTimeHour) >= 12 && int.parse(postedTimeHour) < 23)
              ? 'PM'
              : 'AM';
  String postDate =
      '$postedYear-$postedMonth-$postedDay | $postedTimeHour:$postedTimeMinute$postedTimeZone';
  return postDate;
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