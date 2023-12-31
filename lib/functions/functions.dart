// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/main_home_screen.dart';
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
    errorList.remove('Please enter an email!');
    if (!email.contains('@gmail.com')) {
      if (!userRegFormErrors.contains('Please check your email address!')) {
        userRegFormErrors.add('Please check your email address!');
      }
      if (!errorList.contains('Please check your email address!')) {
        errorList.add('Please check your email address!');
      }
    } else {
      userRegFormErrors.remove('Please check your email address!');
      errorList.remove('Please check your email address!');
    }
  }
}

void passwordValidator(
    {required String password,
    required bool confirmPassword,
    String? password2}) {
  if (password.isEmpty) {
    if (!userRegFormErrors.contains('Please enter your password!')) {
      userRegFormErrors.add('Please enter your password!');
    }
    if (!errorList.contains('Please enter your password!')) {
      errorList.add('Please enter your password!');
    }
  } else {
    userRegFormErrors.remove('Please enter your password!');
    errorList.remove('Please enter your password!');
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
          builder: (context) => MainHomeScreen(),
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