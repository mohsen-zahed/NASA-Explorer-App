import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/widgets/login_account_and_guest_account_texts.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/widgets/privacy_policy_text_acceptance.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/main_home_screen.dart';
import 'package:nasa_explorer_app_project/widgets/custom_elevated_button.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';

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
          child: Padding(
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
                                        hintText: 'Email',
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
                              textButton: isUserLoging ? 'Sign in' : 'Sign up',
                              onPressed: () {
                                setState(() {
                                  // emailValidator(textEditingController2.text);
                                  // debugPrint(
                                  //   errorList.toString(),
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainHomeScreen(),
                                    ),
                                  );
                                });
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
                                });
                              },
                              onGuestAccountTap: () {},
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
        ),
      ),
    );
  }
}
