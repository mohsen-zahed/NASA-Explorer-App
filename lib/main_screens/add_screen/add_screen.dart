// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/services/rand_number_generator.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_elevated_button.dart';
import 'package:nasa_explorer_app_project/widgets/custom_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  static const String id = '/add_screen';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();
  void postImageUpload() async {
    try {
      var postImage;
      postImage = await picker.pickImage(source: ImageSource.gallery);
      final postImageTemp = File(postImage.path);
      setState(() {
        pickedImageForPost = postImageTemp;
      });
    } catch (e) {
      if (mounted) {
        showSnackBar(
            context: context, text: 'failed to upload image!', duration: 4);
      }
    }
  }

  String _pickedPlanetImage =
      'https://th.bing.com/th?id=ORMS.2582b78573108bf8411b106784d31e6e&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1&p=0';
  var _planetName;
  var _planetSubtitle;
  var _planetIntro;
  var _planetHistory;
  var _planetClimate;
  var _planetPickedImageFile;

  var _planetPickedImage;
  bool planetUplaoding = false;
  void selectPlanetImage() async {
    try {
      _planetPickedImage = await picker.pickImage(source: ImageSource.gallery);
      _planetPickedImageFile = File(_planetPickedImage?.path ?? '');
      setState(() {});
    } on FirebaseStorage catch (e) {
      showSnackBar(context: context, text: e.toString(), duration: 3);
    }
  }

  Future<void> uploadPlanet() async {
    try {
      setState(() {
        planetUplaoding = true;
      });
      FirebaseFirestore _planet = FirebaseFirestore.instance;
      var _docIDs = _planet.collection('planetsData').doc().id;
      if (_planetPickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('planetsImages')
            .child(_planetName.toString().trim() + '.png');
        await ref.putFile(_planetPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Planet uploaded successfuly!',
              duration: 3);
        }
        var _downloadedPlanetUrl = await ref.getDownloadURL();
        setState(() {
          _pickedPlanetImage = _downloadedPlanetUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload planet!', duration: 4);
      }
      await _planet.collection('planetsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _pickedPlanetImage,
        'planetName': _planetName,
        'planetSubtitle': _planetSubtitle,
        'planetIntro': _planetIntro,
        'planetHistory': _planetHistory,
        'planetClimate': _planetClimate,
      });
      setState(() {
        planetUplaoding = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            setState(() {
              pickedImageForPost = null;
            });
            return true;
          },
          child: SingleChildScrollView(
            child: BackgroundImageWidget(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => selectPlanetImage(),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: kGreyColor),
                                color: kTransparentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                                  //  _pickedPlanetImage != ''
                                  //     ? CachedNetworkImage(
                                  //         imageUrl: _pickedPlanetImage,
                                  //       )
                                  //     :
                                  _planetPickedImageFile != null
                                      ? Image.file(_planetPickedImageFile)
                                      : const Icon(Icons.camera),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Planet Name',
                            textEditingController: _textEditingController1,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Planet Subtitle',
                            textEditingController: _textEditingController2,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Planet Intro',
                            textEditingController: _textEditingController3,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Planet History',
                            textEditingController: _textEditingController4,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'Planet Climate',
                            textEditingController: _textEditingController5,
                          ),
                          const SizedBox(height: 10),
                          CustomElevatedButton(
                            textButton: planetUplaoding
                                ? 'Uplaoding...'
                                : 'Upload Planet',
                            onPressed: () async {
                              setState(() {
                                _planetName = _textEditingController1.text;
                                _planetSubtitle = _textEditingController2.text;
                                _planetIntro = _textEditingController3.text;
                                _planetHistory = _textEditingController4.text;
                                _planetClimate = _textEditingController5.text;
                              });
                              await uploadPlanet();
                              setState(() {
                                planetUplaoding = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                    // children: [
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             pickedImageForPost = null;
                    //           });
                    //           Navigator.pop(context);
                    //         },
                    //         child: const Icon(
                    //           Icons.arrow_back_ios_new_rounded,
                    //           color: kWhiteColor,
                    //         ),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Text(
                    //           'Share',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyMedium!
                    //               .copyWith(
                    //                 color: kWhiteColor,
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //           textAlign: TextAlign.end,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //   const SizedBox(height: 15),
                    //   Row(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.all(3),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(100),
                    //           border: Border.all(color: kWhiteColor70),
                    //         ),
                    //         child: Container(
                    //           width: 50,
                    //           height: 50,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(100),
                    //             image: const DecorationImage(
                    //               image: AssetImage(
                    //                 'assets/images/profile_pic.jpeg',
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       Text(
                    //         'Amir Mohsen',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyLarge!
                    //             .copyWith(color: kWhiteColor),
                    //       ),
                    //     ],
                    //   ),
                    //   const SizedBox(height: 10),
                    //   Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Expanded(
                    //         child: IconButton(
                    //           onPressed: () {
                    //             postImageUpload();
                    //           },
                    //           icon: const Icon(
                    //             Icons.attach_file_rounded,
                    //             color: kWhiteColor70,
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 7,
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 border: Border.all(
                    //                   color: kWhiteColor70,
                    //                 ),
                    //               ),
                    //               child: TextField(
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .bodyMedium!
                    //                     .copyWith(color: kWhiteColor),
                    //                 decoration: const InputDecoration(
                    //                   border: InputBorder.none,
                    //                   contentPadding: EdgeInsets.symmetric(
                    //                     horizontal: 15,
                    //                     vertical: 10,
                    //                   ),
                    //                 ),
                    //                 maxLines: null,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 10),
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               width: double.infinity,
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 child: pickedImageForPost != null
                    //                     ? Image.file(
                    //                         File(pickedImageForPost!.path),
                    //                       )
                    //                     : const SizedBox(),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
