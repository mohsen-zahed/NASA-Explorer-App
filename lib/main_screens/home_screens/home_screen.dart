import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/add_screen/add_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/advertisement_banner_slider_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/app_logo_and_profile_image.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_astronaut_figures_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_images_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_nasa_missions_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_solar_system_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/news_container_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/search_field.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/image_gallery_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/news_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/profile_screen.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imageUrl;
  var newsContainerImageList = [];
  List<ImageModel> fetchedNewsContainerImageList = [];
  List<String> demoHomeImagesList = [];
  var newsContainerImageResponse;
  final storage = FirebaseStorage.instance;
  String? solarImagesUrl;
  String? imageUrll = '';
  List<String>? imageUrls;
  bool userFirstTimeVisitHome = false;

  @override
  void initState() {
    super.initState();
    fetchNewsContainerImage();
    fetchGalleryImages();
    getPlanetsFromFirebase();
    SharedPreferencesClass().saveUserVisitHomeStatus(alreadyVisited: true);
  }

  Future<void> fetchNewsContainerImage() async {
    try {
      newsContainerImageResponse = await http.get(Uri.parse(newsImageUrl));
      if (newsContainerImageResponse.statusCode == 200) {
        newsContainerImageList = jsonDecode(newsContainerImageResponse.body);
        for (var x in newsContainerImageList) {
          fetchedNewsContainerImageList.add(ImageModel.fromJson(x));
        }
        if (mounted) {
          setState(() {
            imageUrl = fetchedNewsContainerImageList[0].getUrl();
          });
        }
      }
    } on HttpExceptionWithStatus catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchGalleryImages() async {
    try {
      var imagesResponse = await http.get(Uri.parse(imagesUrl));
      if (imagesResponse.statusCode == 200) {
        var imagesList = jsonDecode(imagesResponse.body);
        for (var x in imagesList) {
          fetchedImagesList.add(ImageModel.fromJson(x));
        }

        for (var i = 0; i < 5; i++) {
          demoHomeImagesList.add(fetchedImagesList[i].getUrl());
        }
        if (mounted) {
          setState(() {});
        }
      }
    } on HttpExceptionWithStatus catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 4);
      }
    }
  }

  Future getPlanetsFromFirebase() async {
    final planetsRef = await FirebaseFirestore.instance
        .collection("planetsData")
        .orderBy('id', descending: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data()['id']);
        if (fetchedPlanets.last.getId() < element.data()['id']) {
          fetchedPlanets.add(
            PlanetModel.create(
              element.data()['id'],
              element.data()['planetName'],
              element.data()['imageUrl'],
              element.data()['planetSubtitle'],
              element.data()['planetIntro'],
              element.data()['planetHistory'],
              element.data()['planetClimate'],
            ),
          );
        }
      });
    });
    // for (var i = 0; i < 2; i++) {
    //   setState(() {
    //     demoSolarFetchedPlanets.add(fetchedPlanets[i]);
    //   });
    // }

    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> getSolarImages() async {
  //   try {
  //     // for (var i = 0; i < solarImages.length; i++) {

  //     final ref = storage.ref().child('planetsImages/cjf.jpeg');
  //     final url = await ref.getDownloadURL();
  //     // }
  //     setState(() {
  //       solarImagesUrl = url;
  //     });
  //     print('asdfsadf ${url}');
  //   } on FirebaseException catch (e) {
  //     if (mounted) {
  //       showSnackBar(
  //           context: context, text: e.message.toString(), duration: 10);
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: RefreshIndicator(
            onRefresh: () async {
              await fetchNewsContainerImage();
              await fetchGalleryImages();
              await getPlanetsFromFirebase();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    AppLogoAndProfileImage(
                      imageUrl: demoProfileImageHolder,
                      nasaLogoUrl: 'assets/images/nasa_text_logo.png',
                      onProfileImageTap: () {
                        Navigator.pushNamed(context, ProfileScreen.id);
                      },
                    ),
                    const SizedBox(height: 25),
                    const SearchField(),
                    const SizedBox(height: 15),
                    NewsContainerWidget(
                      newsContainerBackgroundImage: imageUrl,
                      onTap: () {
                        Navigator.pushNamed(context, NewsScreen.id);
                      },
                    ),
                    const SizedBox(height: 25),
                    HorizontalImagesCarouselSlider(
                      imagesList: demoHomeImagesList,
                      onImagesSeeAllTap: () {
                        Navigator.pushNamed(context, ImageGalleryScreen.id);
                      },
                    ),
                    const SizedBox(height: 35),
                    HorizontalSolarSystemCarouselSlider(
                      planetsList: fetchedPlanets,
                      onSolarViewAllTap: () {},
                    ),
                    const SizedBox(height: 35),
                    const AdvertisementBannerSliderWidget(),
                    const SizedBox(height: 35),
                    const HorizontalNASAMissionsCarouselSlider(),
                    const SizedBox(height: 35),
                    const HorizontalAstronautFiguresSlider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AddScreen.id);
        },
        backgroundColor: kGreyColor.withOpacity(0.9),
        label: Text(
          'Share',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: kBlackColor),
        ),
        icon: const Icon(
          Icons.add,
          color: kBlackColor,
        ),
        tooltip: 'Share your information!',
      ),
    );
  }
}
