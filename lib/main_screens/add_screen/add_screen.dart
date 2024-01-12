// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
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

class _AddScreenState extends State<AddScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _planetTextEditingController1 =
      TextEditingController();
  final TextEditingController _planetTextEditingController2 =
      TextEditingController();
  final TextEditingController _planetTextEditingController3 =
      TextEditingController();
  final TextEditingController _planetTextEditingController4 =
      TextEditingController();
  final TextEditingController _planetTextEditingController5 =
      TextEditingController();

  final TextEditingController _missionTextEditingController1 =
      TextEditingController();
  final TextEditingController _missionTextEditingController2 =
      TextEditingController();
  final TextEditingController _missionTextEditingController3 =
      TextEditingController();

  final TextEditingController _astronautTextEditingController1 =
      TextEditingController();
  final TextEditingController _astronautTextEditingController2 =
      TextEditingController();
  final TextEditingController _astronautTextEditingController3 =
      TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  String _pickedPlanetImage = '';
  var _planetName;
  var _planetSubtitle;
  var _planetIntro;
  var _planetHistory;
  var _planetClimate;
  var _planetPickedImageFile;
  var _planetPickedImage;
  bool planetUplaoding = false;
  String _pickedMissionImage = '';
  var _missionName;
  var _missionSubtitle;
  var _missionIntro;
  var _missionPickedImageFile;
  var _missionPickedImage;
  bool missionUplaoding = false;
  String _pickedAstronautImage = '';
  var _astronautName;
  var _astronautSubtitle;
  var _astronautIntro;
  var _astronautPickedImageFile;
  var _astronautPickedImage;
  bool astronautUplaoding = false;

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

  void selectPlanetImage() async {
    try {
      _planetPickedImage = await picker.pickImage(source: ImageSource.gallery);
      _planetPickedImageFile = File(_planetPickedImage?.path ?? '');
      setState(() {});
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectMissionImage() async {
    try {
      _missionPickedImage = await picker.pickImage(source: ImageSource.gallery);
      _missionPickedImageFile = File(_missionPickedImage?.path ?? '');
      setState(() {});
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectAstroImage() async {
    try {
      _astronautPickedImage =
          await picker.pickImage(source: ImageSource.gallery);
      _astronautPickedImageFile = File(_astronautPickedImage?.path ?? '');
      setState(() {});
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
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

  Future<void> uploadMission() async {
    try {
      setState(() {
        missionUplaoding = true;
      });
      FirebaseFirestore _mission = FirebaseFirestore.instance;
      var _docIDs = _mission.collection('NasaMissionsData').doc().id;
      if (_missionPickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('planetsImages')
            .child(_missionName.toString().trim() + '.png');
        await ref.putFile(_missionPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Mission uploaded successfuly!',
              duration: 3);
        }
        var _downloadedMissionUrl = await ref.getDownloadURL();
        setState(() {
          _pickedMissionImage = _downloadedMissionUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload mission!', duration: 4);
      }
      await _mission.collection('NasaMissionsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _pickedMissionImage,
        'missionName': _missionName,
        'missionSubtitle': _missionSubtitle,
        'missionIntro': _missionIntro,
      });
      setState(() {
        missionUplaoding = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  Future<void> uploadAstronaut() async {
    try {
      setState(() {
        astronautUplaoding = true;
      });
      FirebaseFirestore _astro = FirebaseFirestore.instance;
      var _docIDs = _astro.collection('NasaAstronautsData').doc().id;
      if (_astronautPickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('planetsImages')
            .child(_astronautName.toString().trim() + '.png');
        await ref.putFile(_astronautPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Astronaut uploaded successfuly!',
              duration: 3);
        }
        var _downloadedAstronautUrl = await ref.getDownloadURL();
        setState(() {
          _pickedAstronautImage = _downloadedAstronautUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload astronaut!', duration: 4);
      }
      await _astro.collection('NasaAstronautsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _pickedAstronautImage,
        'astronautName': _astronautName,
        'astronautSubtitle': _astronautSubtitle,
        'astronautIntro': _astronautIntro,
      });
      setState(() {
        astronautUplaoding = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _planetTextEditingController1.dispose();
    _planetTextEditingController2.dispose();
    _planetTextEditingController3.dispose();
    _planetTextEditingController4.dispose();
    _planetTextEditingController5.dispose();
    _missionTextEditingController1.dispose();
    _missionTextEditingController2.dispose();
    _missionTextEditingController3.dispose();
    _astronautTextEditingController1.dispose();
    _astronautTextEditingController2.dispose();
    _astronautTextEditingController3.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppWidget(text: 'Share us your information!'),
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                setState(() {
                  pickedImageForPost = null;
                });
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // give the tab bar a height [can change hheight to preferred height]
                    SizedBox(
                      width: getMaxWidthMediaQuery(context),
                      height: 50,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: kWhiteColor,
                        labelColor: kWhiteColor,
                        unselectedLabelColor: kWhiteColor30,
                        tabs: const [
                          Tab(text: 'Planets'),
                          Tab(text: 'NASA Missions'),
                          Tab(text: 'Astronauts'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
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
                                    child: _pickedPlanetImage != ''
                                        ? CachedNetworkImage(
                                            imageUrl: _pickedPlanetImage,
                                          )
                                        : _planetPickedImageFile != null
                                            ? Image.file(_planetPickedImageFile)
                                            : const Icon(
                                                Icons.camera,
                                                color: kWhiteColor30,
                                              ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Planet Name',
                                  textEditingController:
                                      _planetTextEditingController1,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Planet Subtitle',
                                  textEditingController:
                                      _planetTextEditingController2,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Planet Intro',
                                  textEditingController:
                                      _planetTextEditingController3,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Planet History',
                                  textEditingController:
                                      _planetTextEditingController4,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Planet Climate',
                                  textEditingController:
                                      _planetTextEditingController5,
                                ),
                                const SizedBox(height: 10),
                                CustomElevatedButton(
                                  textButton: planetUplaoding
                                      ? 'Uplaoding...'
                                      : 'Upload Planet',
                                  onPressed: () async {
                                    setState(() {
                                      _planetName =
                                          _planetTextEditingController1.text;
                                      _planetSubtitle =
                                          _planetTextEditingController2.text;
                                      _planetIntro =
                                          _planetTextEditingController3.text;
                                      _planetHistory =
                                          _planetTextEditingController4.text;
                                      _planetClimate =
                                          _planetTextEditingController5.text;
                                    });
                                    if (_planetTextEditingController1.text.isNotEmpty &&
                                        _planetTextEditingController2
                                            .text.isNotEmpty &&
                                        _planetTextEditingController3
                                            .text.isNotEmpty &&
                                        _planetTextEditingController4
                                            .text.isNotEmpty &&
                                        _planetTextEditingController5
                                            .text.isNotEmpty) {
                                      await uploadPlanet();
                                    } else {
                                      showSnackBar(
                                          context: context,
                                          text: 'No empty field is allowed!',
                                          duration: 4);
                                    }
                                    setState(() {
                                      planetUplaoding = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => selectMissionImage(),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kGreyColor),
                                    color: kTransparentColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _pickedMissionImage != ''
                                      ? CachedNetworkImage(
                                          imageUrl: _pickedMissionImage,
                                        )
                                      : _missionPickedImageFile != null
                                          ? Image.file(_missionPickedImageFile)
                                          : const Icon(
                                              Icons.camera,
                                              color: kWhiteColor30,
                                            ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Mission Name',
                                textEditingController:
                                    _missionTextEditingController1,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Mission Subtitle',
                                textEditingController:
                                    _missionTextEditingController2,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Mission Intro',
                                textEditingController:
                                    _missionTextEditingController3,
                              ),
                              const SizedBox(height: 10),
                              CustomElevatedButton(
                                textButton: missionUplaoding
                                    ? 'Uplaoding...'
                                    : 'Upload Mission',
                                onPressed: () async {
                                  setState(() {
                                    _missionName =
                                        _missionTextEditingController1.text;
                                    _missionSubtitle =
                                        _missionTextEditingController2.text;
                                    _missionIntro =
                                        _missionTextEditingController3.text;
                                  });
                                  if (_missionTextEditingController1.text.isNotEmpty &&
                                      _missionTextEditingController2
                                          .text.isNotEmpty &&
                                      _missionTextEditingController3
                                          .text.isNotEmpty) {
                                    await uploadMission();
                                  } else {
                                    showSnackBar(
                                        context: context,
                                        text: 'No empty field is allowed!',
                                        duration: 4);
                                  }
                                  setState(() {
                                    missionUplaoding = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => selectAstroImage(),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kGreyColor),
                                    color: kTransparentColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _pickedAstronautImage != ''
                                      ? CachedNetworkImage(
                                          imageUrl: _pickedAstronautImage,
                                        )
                                      : _astronautPickedImageFile != null
                                          ? Image.file(
                                              _astronautPickedImageFile)
                                          : const Icon(
                                              Icons.camera,
                                              color: kWhiteColor30,
                                            ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Astronaut Name',
                                textEditingController:
                                    _astronautTextEditingController1,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Astronaut Subtitle',
                                textEditingController:
                                    _astronautTextEditingController2,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                hintText: 'Astronaut Intro',
                                textEditingController:
                                    _astronautTextEditingController3,
                              ),
                              const SizedBox(height: 10),
                              CustomElevatedButton(
                                textButton: astronautUplaoding
                                    ? 'Uplaoding...'
                                    : 'Upload Astronaut',
                                onPressed: () async {
                                  setState(() {
                                    _astronautName =
                                        _astronautTextEditingController1.text;
                                    _astronautSubtitle =
                                        _astronautTextEditingController2.text;
                                    _astronautIntro =
                                        _astronautTextEditingController3.text;
                                  });
                                  if (_astronautTextEditingController1.text.isNotEmpty &&
                                      _astronautTextEditingController2
                                          .text.isNotEmpty &&
                                      _astronautTextEditingController3
                                          .text.isNotEmpty) {
                                    await uploadAstronaut();
                                  } else {
                                    showSnackBar(
                                        context: context,
                                        text: 'No empty field is allowed!',
                                        duration: 4);
                                  }
                                  setState(() {
                                    astronautUplaoding = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Scaffold(

//       body: SafeArea(
//         child:
//           child: BackgroundImageWidget(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 20, vertical: 30),
//               child: Column(
//                 children: [
                  
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [],
//                     ),
//                   ),
                  
//                 ],
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             pickedImageForPost = null;
//                           });
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: kWhiteColor,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {},
//                         child: Text(
//                           'Share',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(
//                                 color: kWhiteColor,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                           textAlign: TextAlign.end,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           border: Border.all(color: kWhiteColor70),
//                         ),
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             image: const DecorationImage(
//                               image: AssetImage(
//                                 'assets/images/profile_pic.jpeg',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Amir Mohsen',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyLarge!
//                             .copyWith(color: kWhiteColor),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: IconButton(
//                           onPressed: () {
//                             postImageUpload();
//                           },
//                           icon: const Icon(
//                             Icons.attach_file_rounded,
//                             color: kWhiteColor70,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 7,
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: kWhiteColor70,
//                                 ),
//                               ),
//                               child: TextField(
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .copyWith(color: kWhiteColor),
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 15,
//                                     vertical: 10,
//                                   ),
//                                 ),
//                                 maxLines: null,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               width: double.infinity,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: pickedImageForPost != null
//                                     ? Image.file(
//                                         File(pickedImageForPost!.path),
//                                       )
//                                     : const SizedBox(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
