// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/firebase_functions/firebase_functions.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/profile_image_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/saved_posts_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/shared_posts_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/widgets/about_me_dialog_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/widgets/edit_image_profile_change_profile_widgets.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_list_tile_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String id = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController profileTextEditingController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  var imageUrlAfterChange;
  var downloadedImageUrl;
  User? user;
  bool isProfileImageUploading = false;

  void getUserInfo() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      user = auth.currentUser;
      if (user != null) {
        uid = user?.uid;
        final DocumentSnapshot userDocSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (mounted) {
          setState(() {
            userName = userDocSnapshot.get('name');
            userEmail = userDocSnapshot.get('emailAddress');
            userImage = userDocSnapshot.get('imageUrl');
            userSavedPosts = userDocSnapshot.get('savedItems');
          });
        }
      }
    } on FirebaseException catch (e) {
      showSnackBar(context: context, text: e.message.toString(), duration: 4);
    }
  }

  void changeProfileImage() async {
    try {
      setState(() {
        isProfileImageUploading = true;
      });
      var editPickedProfileImage =
          await picker.pickImage(source: ImageSource.gallery);
      var pickedImageFile = File(editPickedProfileImage?.path ?? '');
      if (editPickedProfileImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('usersImage')
            .child('${userName.toString().trim()}.jpeg');
        await ref.putFile(pickedImageFile);
        getUserInfo();
        downloadedImageUrl = await ref.getDownloadURL();
        setState(() {
          userImage = downloadedImageUrl;
        });
        List<String> postsDocIds = await FirebaseFunctions()
            .getDocumentIds(collectionName: 'postsData', context: context);
        for (var i = 0; i < postsDocIds.length; i++) {
          FirebaseFirestore.instance
              .collection('postsData')
              .doc(postsDocIds[i])
              .update({
            'authorImage': downloadedImageUrl,
          });
        }
        List<String> imagesDocIds = await FirebaseFunctions().getDocumentIds(
            collectionName: 'galleryImagesData', context: context);
        for (var i = 0; i < imagesDocIds.length; i++) {
          FirebaseFirestore.instance
              .collection('galleryImagesData')
              .doc(imagesDocIds[i])
              .update({
            'authorImageUrl': downloadedImageUrl,
          });
        }
        showSnackBar(
            context: context,
            text: 'Profile image updated successfuly',
            duration: 3);
      } else {
        showSnackBar(
            context: context,
            text: 'Failed to upload image profile!',
            duration: 4);
        getUserInfo();
        setState(() {});
      }
      setState(() {
        if (downloadedImageUrl != null) {
          imageUrlAfterChange = downloadedImageUrl;
          FirebaseFirestore.instance.collection('users').doc(uid).update({
            'imageUrl': imageUrlAfterChange,
          });
        }
        setState(() {
          isProfileImageUploading = false;
        });
        getUserInfo();
      });
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    } finally {
      // if (mounted) {
      //   setState(() {
      //     isProfileImageUploading = false;
      //   });
      // }
    }
  }

  void updateUserName() async {
    try {
      if (profileTextEditingController.value.text.isNotEmpty) {
        setState(() {
          FirebaseFirestore.instance.collection('users').doc(uid).update({
            'name': profileTextEditingController.text,
          });
          getUserInfo();
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get()
              .then((value) {
            userName = value.data()!['name'];
          });

          Navigator.pop(context);
        });
        List<String> postsDocIds = await FirebaseFunctions()
            .getDocumentIds(context: context, collectionName: 'postsData');
        for (var i = 0; i < postsDocIds.length; i++) {
          setState(() {
            FirebaseFirestore.instance
                .collection('postsData')
                .doc(postsDocIds[i])
                .update({
              'author': profileTextEditingController.text,
            });
          });
        }
        List<String> imagesDocIds = await FirebaseFunctions().getDocumentIds(
            context: context, collectionName: 'galleryImagesData');
        for (var i = 0; i < imagesDocIds.length; i++) {
          FirebaseFirestore.instance
              .collection('galleryImagesData')
              .doc(imagesDocIds[i])
              .update({
            'authorName': profileTextEditingController.text,
          });
        }
        profileTextEditingController.clear();
        if (mounted) {
          showSnackBar(
              context: context, text: 'Username updated!', duration: 3);
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    profileTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          setState(() {
            userImage = userImage;
            getUserInfo();
          });
          Navigator.pop(context);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: BackgroundImageWidget(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    EditImageProfileChangeImageWidgets(
                      isImageUploading: isProfileImageUploading,
                      urlImage: userImage ?? demoProfileImageHolder,
                      name: userName ?? 'loading name...',
                      email: userEmail ?? 'example@gmail.com',
                      onEditTap: () => editProfileName(context),
                      onCameraTap: () => changeProfileImage(),
                      onImageTap: () => Navigator.pushNamed(
                        context,
                        ProfileImageScreen.id,
                        arguments: {
                          'url': userImage ?? demoProfileImageHolder,
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomListTileWidget(
                      text: 'Saved Posts',
                      leadingIcon: Icons.bookmark,
                      onListTileTap: () {
                        Navigator.pushNamed(
                          context,
                          SavedPostsScreen.id,
                          arguments: {
                            'comingFromSaved': true,
                            'title': 'Saved Posts',
                          },
                        );
                      },
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
                              await FirebaseFunctions()
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
      ),
    );
  }

  Future<dynamic> editProfileName(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kScaffoldBackgroundColor,
        surfaceTintColor: kScaffoldBackgroundColor,
        title: Text(
          'Edit Profile',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: kWhiteColor),
        ),
        content: SizedBox(
          height: getMaxHieghtMediaQuery(context, 0.1),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: profileTextEditingController,
                hintText: 'Enter your new name',
                hintTextColor: kWhiteColor,
                prefixIcon: Icons.person,
                prefixIconColor: kWhiteColor,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
              TextButton(
                child: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kWhiteColor),
                ),
                onPressed: () {
                  updateUserName();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
