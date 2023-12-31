// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/firebase_functions/firebase_functions.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/sub_screens/shared_posts_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/widgets/about_me_dialog_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/widgets/edit_image_profile_change_profile_widgets.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_elevated_button.dart';
import 'package:nasa_explorer_app_project/widgets/custom_list_tile_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController profileTextEditingController =
      TextEditingController();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  var userName;
  var userEmail;
  var userImage;
  void getUserInfo() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      userName = user.displayName;
      userEmail = user.email;
    }
  }

  void changeProfileImage() async {
    try {
      var editPickedProfileImage;
      editPickedProfileImage =
          await picker.pickImage(source: ImageSource.gallery);
      final imageTemp = File(editPickedProfileImage.path);
      setState(() {
        pickedImageForProf = imageTemp;
      });
    } catch (e) {
      showSnackBar(
          context: context,
          text: 'Failed to change profile image!',
          duration: 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  EditImageProfileChangeImageWidgets(
                    name: userName ?? 'name',
                    email: userEmail ?? 'example@gmail.com',
                    onEditTap: () => editProfileName(context),
                    onImageTap: () => changeProfileImage(),
                  ),
                  const SizedBox(height: 30),
                  CustomListTileWidget(
                    text: 'Saved Posts',
                    leadingIcon: Icons.bookmark,
                    onListTileTap: () {},
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 10),
                  CustomListTileWidget(
                    text: 'Shared Posts',
                    leadingIcon: Icons.content_paste_go_outlined,
                    onListTileTap: () {
                      Navigator.pushNamed(
                        context,
                        SharedPostsScreen.id,
                      );
                    },
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 10),
                  CustomListTileWidget(
                    text: 'Share app with friends',
                    leadingIcon: Icons.share,
                    onListTileTap: () => shareAppWithFriends(context),
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 10),
                  CustomListTileWidget(
                    text: 'Like Me',
                    leadingIcon: Icons.thumb_up_alt_rounded,
                    onListTileTap: () => redirectToSocialMedia(
                      link:
                          'https://instagram.com/mohsen_zahed80?igshid=OGQ5ZDc2ODk2ZA==',
                      context: context,
                    ),
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 10),
                  CustomListTileWidget(
                    text: 'About Me',
                    leadingIcon: Icons.warning_amber_rounded,
                    onListTileTap: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return const AboutMeDialogWidget(
                          title: 'About Me',
                          buttonText: 'Close',
                          isAboutMe: true,
                        );
                      },
                    ),
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 30),
                  CustomListTileWidget(
                    text: 'Sign Out',
                    leadingIcon: Icons.logout,
                    onListTileTap: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AboutMeDialogWidget(
                          title: 'Signing Out',
                          isAboutMe: false,
                          text: 'Are you sure?\nYou\'ll have to login again!',
                          buttonText: 'Continue',
                          onTap: () async {
                            await FirebaseFunctions(FirebaseAuth.instance)
                                .signOutUser(context: context);
                          },
                        );
                      },
                    ),
                    trailingIcon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'App ver. 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: kGreyColor,
                          decoration: TextDecoration.underline,
                          wordSpacing: .1,
                          fontWeight: FontWeight.bold,
                          decorationColor: kGreyColor,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> editProfileName(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kScaffoldBackgroundColor,
        title: const Text('About Me'),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextField(
                textEditingController: profileTextEditingController,
                hintText: 'Enter your new name',
              ),
              CustomElevatedButton(
                textButton: 'Submit',
                onPressed: () {
                  if (profileTextEditingController.value.text.isNotEmpty) {
                    setState(() {
                      userName = profileTextEditingController.value.text;
                      Navigator.pop(context);
                      profileTextEditingController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kWhiteColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
