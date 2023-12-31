// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/firebase_functions/firebase_functions.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/widgets/login_account_and_guest_account_texts.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/widgets/privacy_policy_text_acceptance.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/main_home_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/profile_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/widgets/about_me_dialog_widget.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';
import 'package:nasa_explorer_app_project/widgets/custom_elevated_button.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool isUserLoging = false;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  TextEditingController textEditingController6 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void removeErrors() async {
    try {
      for (var i = 0; i < errorList.length; i++) {
        await Future.delayed(const Duration(seconds: 4));
        if (errorList.isNotEmpty) {
          errorList.removeAt(i);
          if (mounted) {
            setState(() {});
          }
        }
      }
    } finally {
      print('error List cleared');
      errorList.clear();
      if (mounted) {
        setState(() {});
      }
    }
  }

  bool isSubmitingUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Sign in or Sign up to start exploring!',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 35,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 40,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Please fill the blank form to continue exploring universe and earth!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: kWhiteColor70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                !isUserLoging
                                    ? Column(
                                        children: [
                                          const SizedBox(height: 50),
                                          CustomTextField(
                                            hintText: 'Username',
                                            prefixIcon:
                                                Icons.person_add_alt_1_rounded,
                                            errorText: '',
                                            focusNode: focusNode1,
                                            textEditingController:
                                                textEditingController1,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            textInputType:
                                                TextInputType.emailAddress,
                                            hintText: 'Email address',
                                            prefixIcon: Icons.email,
                                            errorText: '',
                                            focusNode: focusNode2,
                                            textEditingController:
                                                textEditingController2,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Password',
                                            prefixIcon: Icons.lock,
                                            errorText: '',
                                            obsecuredField: showPassword,
                                            isPasswordField: true,
                                            suffixIcon: Icons.remove_red_eye,
                                            onSuffixIconTap: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            textEditingController:
                                                textEditingController3,
                                            focusNode: focusNode3,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Confirm password',
                                            prefixIcon: Icons.lock,
                                            errorText: '',
                                            obsecuredField: showConfirmPassword,
                                            isPasswordField: true,
                                            suffixIcon: Icons.remove_red_eye,
                                            onSuffixIconTap: () {
                                              setState(() {
                                                showConfirmPassword =
                                                    !showConfirmPassword;
                                              });
                                            },
                                            textEditingController:
                                                textEditingController4,
                                            focusNode: focusNode4,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          const SizedBox(height: 50),
                                          CustomTextField(
                                            hintText: 'Email',
                                            textInputType:
                                                TextInputType.emailAddress,
                                            prefixIcon: Icons.email,
                                            errorText: '',
                                            focusNode: focusNode5,
                                            textEditingController:
                                                textEditingController5,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Password',
                                            prefixIcon: Icons.lock,
                                            errorText: '',
                                            isPasswordField: true,
                                            obsecuredField: showPassword,
                                            suffixIcon: Icons.remove_red_eye,
                                            onSuffixIconTap: () {
                                              setState(() {
                                                showPassword = !showPassword;
                                              });
                                            },
                                            textEditingController:
                                                textEditingController6,
                                            focusNode: focusNode6,
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 5),
                                !isUserLoging
                                    ? const PrivacyPolicyTextAcceptance()
                                    : const SizedBox(),
                                const Spacer(),
                                CustomElevatedButton(
                                  textButton:
                                      isUserLoging ? 'Sign in' : 'Sign up',
                                  onPressed: () async {
                                    isUserConnected =
                                        await checkInternetConnectivity(
                                            context);
                                    if (isUserConnected) {
                                      if (!isUserLoging) {
                                        emailValidator(
                                            textEditingController2.text);
                                        passwordValidator(
                                          password: textEditingController3.text,
                                          password2:
                                              textEditingController4.text,
                                          confirmPassword: true,
                                        );

                                        removeErrors();
                                        setState(() {
                                          isSubmitingUser = true;
                                        });
                                        if (userRegFormErrors.isEmpty) {
                                          await FirebaseFunctions(
                                                  FirebaseAuth.instance)
                                              .signUpWithEmail(
                                            name: textEditingController1.text,
                                            email: textEditingController2.text,
                                            password:
                                                textEditingController3.text,
                                            context: context,
                                          );
                                          var isSaved =
                                              await SharedPreferencesClass()
                                                  .saveLoginStatusToSharedPreferences(
                                                      isLoggedIn: true);
                                          isSaved == true
                                              ? Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainHomeScreen(),
                                                  ),
                                                  (route) => false,
                                                )
                                              : showSnackBar(
                                                  context: context,
                                                  text:
                                                      'Something went wrong, try again!',
                                                  duration: 3);
                                        }
                                        setState(() {
                                          isSubmitingUser = false;
                                        });
                                      } else {
                                        emailValidator(
                                            textEditingController5.text);
                                        passwordValidator(
                                          password: textEditingController6.text,
                                          confirmPassword: false,
                                        );
                                        removeErrors();
                                        setState(() {
                                          isSubmitingUser = true;
                                        });
                                        if (userRegFormErrors.isEmpty) {
                                          await FirebaseFunctions(
                                                  FirebaseAuth.instance)
                                              .signInWithEmail(
                                            email: textEditingController5.text,
                                            password:
                                                textEditingController6.text,
                                            context: context,
                                          );
                                          var isSaved =
                                              await SharedPreferencesClass()
                                                  .saveLoginStatusToSharedPreferences(
                                                      isLoggedIn: true);
                                          isSaved == true
                                              ? Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainHomeScreen(),
                                                  ),
                                                  (route) => false,
                                                )
                                              : showSnackBar(
                                                  context: context,
                                                  text:
                                                      'Something went wrong, try again!',
                                                  duration: 3);
                                        }
                                        setState(() {
                                          isSubmitingUser = false;
                                        });
                                      }
                                    } else {
                                      showAdaptiveDialog(
                                        context: context,
                                        builder: (context) =>
                                            const AboutMeDialogWidget(
                                          title: 'Oops, something went wrong!',
                                          isAboutMe: false,
                                          text:
                                              'We apologize, but it seems that there was a problem connecting to the server.\nPlease check your internet connection and try again.',
                                          buttonText: 'Got it!',
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                LoginAccountAndGuestAccountTexts(
                                  text: !isUserLoging
                                      ? 'Already have an account?'
                                      : 'Don\'t have an account?',
                                  onAlreadyHaveAccountTap: () {
                                    setState(() {
                                      isUserLoging = !isUserLoging;
                                      textEditingController1.clear();
                                      textEditingController2.clear();
                                      textEditingController3.clear();
                                      textEditingController4.clear();
                                      textEditingController5.clear();
                                      textEditingController6.clear();
                                      userRegFormErrors.clear();
                                    });
                                  },
                                  onGuestAccountTap: () async {
                                    await FirebaseFunctions(
                                            FirebaseAuth.instance)
                                        .signInAnonymously(context);
                                    var isSaved = await SharedPreferencesClass()
                                        .saveLoginStatusToSharedPreferences(
                                            isLoggedIn: true);
                                    isSaved == true
                                        ? Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainHomeScreen(),
                                            ),
                                            (route) => false,
                                          )
                                        : showSnackBar(
                                            context: context,
                                            text:
                                                'Something went wrong, try again!',
                                            duration: 3);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isSubmitingUser
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    ...List.generate(
                      errorList.length,
                      (index) => Container(
                        width: getMaxWidthMediaQuery(context),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kScaffoldBackgroundColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: kRedColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      errorList[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: kWhiteColor),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  errorList.removeAt(index);
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                color: kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
