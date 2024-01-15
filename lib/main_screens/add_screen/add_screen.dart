// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/add_screen/widgets/custom_post_text_field.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/home_screen.dart';
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
  final TextEditingController _postTextEditingController1 =
      TextEditingController();
  final TextEditingController _postTextEditingController2 =
      TextEditingController();

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

  final TextEditingController _newsTextEditingController =
      TextEditingController();

  final TextEditingController _galleryTextEditingController =
      TextEditingController();

  final TextEditingController _bannerTextEditingController1 =
      TextEditingController();
  final TextEditingController _bannerTextEditingController2 =
      TextEditingController();
  final TextEditingController _bannerTextEditingController3 =
      TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  bool isPosting = true;

  //* home screen news container widget vars
  String _urlDownloadNewsImage = '';
  String _newsDescription = '';
  var _newsPickedImageFile;
  var _newsPickedImage;
  bool newsUploading = false;

  //* home screen horizontal carousel images widget vars
  String _urlDownloadGalleryImage = '';
  var _galleryPickedImage;
  var _galleryPickedImageFile;
  var _galleryImageDesc;
  bool galleryUploading = false;

  //* home screen solar system vars
  String _urlDownloadPlanetImage = '';
  var _planetName;
  var _planetSubtitle;
  var _planetIntro;
  var _planetHistory;
  var _planetClimate;
  var _planetPickedImageFile;
  var _planetPickedImage;
  bool planetUplaoding = false;

  //* home screen nasa missions vars
  String _urlDownloadMissionImage = '';
  var _missionName;
  var _missionSubtitle;
  var _missionIntro;
  var _missionPickedImageFile;
  var _missionPickedImage;
  bool missionUplaoding = false;

  //* home screen astronauts vars
  String _urlDownloadAstronautImage = '';
  var _astronautName;
  var _astronautSubtitle;
  var _astronautIntro;
  var _astronautPickedImageFile;
  var _astronautPickedImage;
  bool astronautUplaoding = false;

  //* home screen advertisment banner vars
  String _urlDownloadBannerImage = '';
  var _bannerMessage;
  var _bannerName;
  var _bannerImageUrl;
  var _bannerDesc;
  var _bannerPickedImage;
  var _bannerPickedImageFile;
  bool bannerUploading = false;

  //* add screen vars
  bool isPostUploading = false;
  var _postPickedImage;
  var _postPickedImageFile;
  var _urlDownloadPostImage;
  var _postDescription;
  var _postTitle;

  void selectPostImage() async {
    try {
      _postPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_postPickedImage != null) {
        setState(() {
          _postPickedImageFile = File(_postPickedImage?.path ?? '');
        });
      }
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  void selectNewsImage() async {
    try {
      _newsPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_newsPickedImage != null) {
        setState(() {
          _newsPickedImageFile = File(_newsPickedImage?.path ?? '');
        });
      }
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectGalleryImage() async {
    try {
      _galleryPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_galleryPickedImage != null) {
        setState(() {
          _galleryPickedImageFile = File(_galleryPickedImage?.path ?? '');
        });
      }
      setState(() {});
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectPlanetImage() async {
    try {
      _planetPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_planetPickedImage != null) {
        setState(() {
          _planetPickedImageFile = File(_planetPickedImage?.path ?? '');
        });
      }
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectMissionImage() async {
    try {
      _missionPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_missionPickedImage != null) {
        setState(() {
          _missionPickedImageFile = File(_missionPickedImage?.path ?? '');
        });
      }
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
      if (_astronautPickedImage != null) {
        setState(() {
          _astronautPickedImageFile = File(_astronautPickedImage?.path ?? '');
        });
      }
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  void selectBannerImage() async {
    try {
      _bannerPickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (_bannerPickedImage != null) {
        setState(() {
          _bannerPickedImageFile = File(_bannerPickedImage?.path ?? '');
        });
      }
    } on FirebaseStorage catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 3);
      }
    }
  }

  Future<void> uploadPost() async {
    try {
      setState(() {
        isPostUploading = true;
      });
      var _id = NumberGenerator.generateNumber();
      FirebaseFirestore _posts = FirebaseFirestore.instance;
      var _docIDs = _posts.collection('postsData').doc().id;
      if (_postPickedImage != null) {
        var imageName = joinWords(text: _postDescription);
        var imageName2 = '$userName-$imageName';
        final ref = FirebaseStorage.instance
            .ref()
            .child('postsImages')
            .child(imageName2.toString().trim() + '.png');
        await ref.putFile(_postPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Post uploaded successfuly!',
              duration: 3);
        }
        _urlDownloadPostImage = await ref.getDownloadURL();
        setState(() {
          _urlDownloadPostImage = _urlDownloadPostImage;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload post!', duration: 4);
      }
      String date = getDate();
      await _posts.collection('postsData').doc(_docIDs).set({
        'id': _id,
        'author': userName,
        'authorImage': userImage,
        'postImageUrl': _urlDownloadPostImage,
        'postTitle': _postTitle,
        'postDescription': _postDescription,
        'postedDate': date,
        'postLikesCount': 0,
        'postIsLike': false,
      });
      setState(() {
        isPostUploading = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  Future<void> uploadNews() async {
    try {
      setState(() {
        newsUploading = true;
      });
      var _id = NumberGenerator.generateNumber();
      FirebaseFirestore _news = FirebaseFirestore.instance;
      var _docIDs = _news.collection('newsBannerData').doc().id;
      if (_newsPickedImage != null) {
        var imageName = joinWords(text: _newsDescription);
        final ref = FirebaseStorage.instance
            .ref()
            .child('newsBannerImages')
            .child(imageName.toString().trim() + '.png');
        await ref.putFile(_newsPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'News uploaded successfuly!',
              duration: 3);
        }
        _urlDownloadNewsImage = await ref.getDownloadURL();
        setState(() {
          _urlDownloadNewsImage = _urlDownloadNewsImage;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload news!', duration: 4);
      }
      String date = getDate();
      await _news.collection('newsBannerData').doc(_docIDs).set({
        'id': _id,
        'newsImageUrl': _urlDownloadNewsImage,
        'newsDescription': _newsDescription,
        'postedDate': date,
      });
      setState(() {
        newsUploading = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  Future<void> uploadGallery() async {
    try {
      setState(() {
        galleryUploading = true;
      });
      var _id = NumberGenerator.generateNumber();
      FirebaseFirestore _gallery = FirebaseFirestore.instance;
      var _docIDs = _gallery.collection('galleryImages').doc().id;
      if (_galleryPickedImage != null) {
        var imageName = joinWords(text: _galleryImageDesc);
        final ref = FirebaseStorage.instance
            .ref()
            .child('galleryImages')
            .child(imageName.toString().trim() + '.png');
        await ref.putFile(_galleryPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Gallery uploaded successfuly!',
              duration: 3);
        }
        _urlDownloadGalleryImage = await ref.getDownloadURL();
        setState(() {
          _urlDownloadGalleryImage = _urlDownloadGalleryImage;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload gallery!', duration: 4);
      }
      String date = getDate();
      await _gallery.collection('galleryImagesData').doc(_docIDs).set({
        'id': _id,
        'galleryImageUrl': _urlDownloadGalleryImage,
        'galleryDescription': _galleryImageDesc,
        'postedDate': date,
      });
      setState(() {
        galleryUploading = false;
      });
    } on FirebaseFirestore catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
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
          _urlDownloadPlanetImage = _downloadedPlanetUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload planet!', duration: 4);
      }
      String date = getDate();
      await _planet.collection('planetsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _urlDownloadPlanetImage,
        'planetName': _planetName,
        'planetSubtitle': _planetSubtitle,
        'planetIntro': _planetIntro,
        'planetHistory': _planetHistory,
        'planetClimate': _planetClimate,
        'postedDate': date,
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
          _urlDownloadMissionImage = _downloadedMissionUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload mission!', duration: 4);
      }
      String date = getDate();
      await _mission.collection('NasaMissionsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _urlDownloadMissionImage,
        'missionName': _missionName,
        'missionSubtitle': _missionSubtitle,
        'missionIntro': _missionIntro,
        'postedDate': date,
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
          _urlDownloadAstronautImage = _downloadedAstronautUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload astronaut!', duration: 4);
      }
      String date = getDate();
      await _astro.collection('NasaAstronautsData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _urlDownloadAstronautImage,
        'astronautName': _astronautName,
        'astronautSubtitle': _astronautSubtitle,
        'astronautIntro': _astronautIntro,
        'postedDate': date,
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

  Future<void> uploadAdBanner() async {
    try {
      setState(() {
        bannerUploading = true;
      });
      FirebaseFirestore _banner = FirebaseFirestore.instance;
      var _docIDs = _banner.collection('AdBannerData').doc().id;
      if (_bannerPickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('adBannerImages')
            .child(_bannerName.toString().trim() + '.png');
        await ref.putFile(_bannerPickedImageFile);
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'ADBanner uploaded successfuly!',
              duration: 3);
        }
        var _downloadedBannerUrl = await ref.getDownloadURL();
        setState(() {
          _urlDownloadBannerImage = _downloadedBannerUrl;
        });
      } else {
        showSnackBar(
            context: context, text: 'Failed to upload ADBanner!', duration: 4);
      }
      String date = getDate();
      await _banner.collection('AdBannerData').doc(_docIDs).set({
        'id': NumberGenerator.generateNumber(),
        'imageUrl': _urlDownloadBannerImage,
        'bannerName': _bannerName,
        'bannerDescription': _bannerDesc,
        'bannerMessage': _bannerMessage,
        'postedDate': date,
      });
      setState(() {
        bannerUploading = false;
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
    _newsTextEditingController.dispose();
    _galleryTextEditingController.dispose();
    _postTextEditingController1.dispose();
    _postTextEditingController2.dispose();
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
                  _postPickedImageFile = null;
                });
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isPosting
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border:
                                            Border.all(color: kWhiteColor70),
                                      ),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                userImage ??
                                                    demoProfileImageHolder),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      userName ?? 'name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      _postTitle =
                                          _postTextEditingController1.text;
                                      _postDescription =
                                          _postTextEditingController2.text;
                                    });
                                    if (_postTextEditingController2.text.isNotEmpty &&
                                        _postTextEditingController1
                                            .text.isNotEmpty &&
                                        _postPickedImageFile != null) {
                                      await uploadPost();
                                      setState(() {
                                        _postTextEditingController1.clear();
                                        _postTextEditingController2.clear();
                                        _postPickedImageFile = null;
                                        _postPickedImage = '';
                                      });
                                    } else {
                                      showSnackBar(
                                          context: context,
                                          text:
                                              'Please insert something to upload!',
                                          duration: 4);
                                    }
                                    setState(() {
                                      isPostUploading = false;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: kWhiteColor70,
                                  ),
                                  child: Text(
                                    isPostUploading ? 'Sharing...' : 'Share',
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          decorationColor: kWhiteColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: () => selectPostImage(),
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: kWhiteColor70,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: CustomPostTextField(
                                          postTextEditingController:
                                              _postTextEditingController1,
                                          hintText: 'Post title',
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: CustomPostTextField(
                                          postTextEditingController:
                                              _postTextEditingController2,
                                          hintText: 'Post Description',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:
                                                  _postPickedImageFile != null
                                                      ? Image.file(
                                                          _postPickedImageFile)
                                                      : const SizedBox(),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _postPickedImageFile = null;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(
                          height: getMaxHieghtMediaQuery(context),
                          child: Column(
                            children: [
                              SizedBox(
                                width: getMaxWidthMediaQuery(context),
                                height: 50,
                                child: TabBar(
                                  isScrollable: true,
                                  controller: _tabController,
                                  indicatorColor: kWhiteColor,
                                  labelColor: kWhiteColor,
                                  unselectedLabelColor: kWhiteColor30,
                                  tabs: const [
                                    Tab(text: 'News Container'),
                                    Tab(text: 'GalleryImages'),
                                    Tab(text: 'Planets'),
                                    Tab(text: 'NASA Missions'),
                                    Tab(text: 'Astronauts'),
                                    Tab(text: 'ADBanner'),
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
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () => selectNewsImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _newsPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _newsPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _newsPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _newsPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'News Description',
                                            textEditingController:
                                                _newsTextEditingController,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomElevatedButton(
                                            textButton: newsUploading
                                                ? 'Uplaoding...'
                                                : 'Upload News',
                                            onPressed: () async {
                                              setState(() {
                                                _newsDescription =
                                                    _newsTextEditingController
                                                        .text;
                                              });
                                              if (_newsTextEditingController
                                                      .text.isNotEmpty &&
                                                  _newsPickedImageFile !=
                                                      null) {
                                                await uploadNews();
                                                setState(() {
                                                  _newsTextEditingController
                                                      .clear();
                                                  _newsPickedImageFile = null;
                                                  _urlDownloadNewsImage = '';
                                                });
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
                                                    duration: 4);
                                              }
                                              setState(() {
                                                newsUploading = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    selectGalleryImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _galleryPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _galleryPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _galleryPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _galleryPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Image Description',
                                            textEditingController:
                                                _galleryTextEditingController,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomElevatedButton(
                                            textButton: galleryUploading
                                                ? 'Uplaoding...'
                                                : 'Upload Gallery',
                                            onPressed: () async {
                                              setState(() {
                                                _galleryImageDesc =
                                                    _galleryTextEditingController
                                                        .text;
                                              });
                                              if (_galleryTextEditingController
                                                      .text.isNotEmpty &&
                                                  _galleryPickedImageFile !=
                                                      null) {
                                                await uploadGallery();
                                                setState(() {
                                                  _galleryTextEditingController
                                                      .clear();
                                                  _galleryPickedImage = '';
                                                  _galleryPickedImageFile =
                                                      null;
                                                });
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
                                                    duration: 4);
                                              }
                                              setState(() {
                                                galleryUploading = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    selectPlanetImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _planetPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _planetPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _planetPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _planetPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
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
                                                    _planetTextEditingController1
                                                        .text;
                                                _planetSubtitle =
                                                    _planetTextEditingController2
                                                        .text;
                                                _planetIntro =
                                                    _planetTextEditingController3
                                                        .text;
                                                _planetHistory =
                                                    _planetTextEditingController4
                                                        .text;
                                                _planetClimate =
                                                    _planetTextEditingController5
                                                        .text;
                                              });
                                              if (_planetTextEditingController1.text.isNotEmpty &&
                                                  _planetTextEditingController2
                                                      .text.isNotEmpty &&
                                                  _planetTextEditingController3
                                                      .text.isNotEmpty &&
                                                  _planetTextEditingController4
                                                      .text.isNotEmpty &&
                                                  _planetTextEditingController5
                                                      .text.isNotEmpty &&
                                                  _planetPickedImageFile !=
                                                      null) {
                                                await uploadPlanet();
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
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
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    selectMissionImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _missionPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _missionPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _missionPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _missionPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
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
                                                    _missionTextEditingController1
                                                        .text;
                                                _missionSubtitle =
                                                    _missionTextEditingController2
                                                        .text;
                                                _missionIntro =
                                                    _missionTextEditingController3
                                                        .text;
                                              });
                                              if (_missionTextEditingController1.text.isNotEmpty &&
                                                  _missionTextEditingController2
                                                      .text.isNotEmpty &&
                                                  _missionTextEditingController3
                                                      .text.isNotEmpty &&
                                                  _missionPickedImageFile !=
                                                      null) {
                                                await uploadMission();
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
                                                    duration: 4);
                                              }
                                              setState(() {
                                                missionUplaoding = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () => selectAstroImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _astronautPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _astronautPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _astronautPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _astronautPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
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
                                                    _astronautTextEditingController1
                                                        .text;
                                                _astronautSubtitle =
                                                    _astronautTextEditingController2
                                                        .text;
                                                _astronautIntro =
                                                    _astronautTextEditingController3
                                                        .text;
                                              });
                                              if (_astronautTextEditingController1.text.isNotEmpty &&
                                                  _astronautTextEditingController2
                                                      .text.isNotEmpty &&
                                                  _astronautTextEditingController3
                                                      .text.isNotEmpty &&
                                                  _astronautPickedImageFile !=
                                                      null) {
                                                await uploadAstronaut();
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
                                                    duration: 4);
                                              }
                                              setState(() {
                                                astronautUplaoding = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    selectBannerImage(),
                                                child: Container(
                                                  width: getMaxWidthMediaQuery(
                                                      context),
                                                  height:
                                                      getMaxHieghtMediaQuery(
                                                          context, 0.25),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: kGreyColor),
                                                    color: kTransparentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: _bannerPickedImageFile !=
                                                          null
                                                      ? Image.file(
                                                          _bannerPickedImageFile)
                                                      : const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: kWhiteColor30,
                                                          size: 100,
                                                        ),
                                                ),
                                              ),
                                              _bannerPickedImageFile != null
                                                  ? Positioned(
                                                      right: 0,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.cancel),
                                                        onPressed: () {
                                                          setState(() {
                                                            _bannerPickedImageFile =
                                                                null;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Banner Name',
                                            textEditingController:
                                                _bannerTextEditingController1,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Banner Message',
                                            textEditingController:
                                                _bannerTextEditingController2,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextField(
                                            hintText: 'Banner Description',
                                            textEditingController:
                                                _bannerTextEditingController3,
                                          ),
                                          const SizedBox(height: 10),
                                          CustomElevatedButton(
                                            textButton: bannerUploading
                                                ? 'Uplaoding...'
                                                : 'Upload ADBanner',
                                            onPressed: () async {
                                              setState(() {
                                                _bannerName =
                                                    _bannerTextEditingController1
                                                        .text;
                                                _bannerMessage =
                                                    _bannerTextEditingController2
                                                        .text;
                                                _bannerDesc =
                                                    _bannerTextEditingController3
                                                        .text;
                                              });
                                              if (_bannerTextEditingController1.text.isNotEmpty &&
                                                  _bannerTextEditingController2
                                                      .text.isNotEmpty &&
                                                  _bannerTextEditingController3
                                                      .text.isNotEmpty &&
                                                  _bannerPickedImageFile !=
                                                      null) {
                                                await uploadAdBanner();
                                                setState(() {
                                                  _bannerTextEditingController1
                                                      .clear();
                                                  _bannerTextEditingController2
                                                      .clear();
                                                  _bannerTextEditingController3
                                                      .clear();
                                                  _bannerPickedImage = '';
                                                  _bannerPickedImageFile = null;
                                                });
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    text:
                                                        'No empty field or image is allowed!',
                                                    duration: 4);
                                              }
                                              setState(() {
                                                bannerUploading = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kWhiteColor30,
        foregroundColor: kWhiteColor70,
        onPressed: () {
          setState(() {
            isPosting = !isPosting;
            _planetTextEditingController1.clear();
            _planetTextEditingController2.clear();
            _planetTextEditingController3.clear();
            _planetTextEditingController4.clear();
            _planetTextEditingController5.clear();
            _missionTextEditingController1.clear();
            _missionTextEditingController2.clear();
            _missionTextEditingController3.clear();
            _astronautTextEditingController1.clear();
            _astronautTextEditingController2.clear();
            _astronautTextEditingController3.clear();
            _newsTextEditingController.clear();
            _galleryTextEditingController.clear();
            _postTextEditingController1.clear();
            _postTextEditingController2.clear();
            _newsPickedImage = '';
            _newsPickedImageFile = null;
            _galleryPickedImage = '';
            _galleryPickedImageFile = null;
            _planetPickedImage = '';
            _planetPickedImageFile = null;
            _missionPickedImage = '';
            _missionPickedImageFile = null;
            _astronautPickedImage = '';
            _astronautPickedImageFile = null;
            _bannerPickedImage = '';
            _bannerPickedImageFile = null;
          });
        },
        child: Icon(
          isPosting ? Icons.toggle_on_outlined : Icons.toggle_off_outlined,
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
