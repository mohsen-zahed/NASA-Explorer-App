import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/advertisement_banner_slider_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/app_logo_and_profile_image.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_astronaut_figures_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_images_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_nasa_missions_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_solar_system_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/news_container_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/search_field.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
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
  Future<String>? solarImagesUrl;
  String? imageUrll = '';
  List<String>? imageUrls;

  @override
  void initState() {
    super.initState();
    fetchNewsContainerImage();
    fetchImages();
    // getSolarImages();
    getPlanetsFromFirebase();
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
    } catch (e) {
      showSnackBar(
          context: context,
          text: 'Something went wrong, try again!',
          duration: 200);
    }
  }

  Future<void> fetchImages() async {
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
        print('object');
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('failed');
    }
  }

  Future getPlanetsFromFirebase() async {
    final planetsRef = FirebaseFirestore.instance
        .collection("PlanetsData")
        .orderBy(descending: false, 'id');
    await planetsRef.get().then(
          (value) => value.docs.forEach(
            (element) {
              fetchedPlanets.add(
                PlanetModel.create(
                  element.data()['id'],
                  element.data()['planet_name'],
                  element.data()['planet_sub_title'],
                  element.data()['planet_intro'],
                  element.data()['planet_history'],
                  element.data()['planet_climate'],
                ),
              );
            },
          ),
        );
    if (mounted) {
      setState(() {});
    }
  }

  // Future<void> getSolarImages() async {
  //   // for (var i = 0; i < solarImages.length; i++) {
  //   var ref = storage.ref().child('moon.png').getDownloadURL();
  //   // }
  //   setState(() {
  //     solarImagesUrl = ref;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
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
                  ),
                  const SizedBox(height: 25),
                  const SearchField(),
                  const SizedBox(height: 15),
                  NewsContainerWidget(
                    newsContainerBackgroundImage: imageUrl,
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  HorizontalImagesCarouselSlider(
                    imagesList: demoHomeImagesList,
                  ),
                  const SizedBox(height: 35),
                  HorizontalSolarSystemCarouselSlider(
                    planetsList: fetchedPlanets,
                  ),
                  const SizedBox(height: 35),
                  const AdvertisementBannerSliderWidget(),
                  const SizedBox(height: 35),
                  const HorizontalNASAMissionsCarouselSlider(),
                  const SizedBox(height: 35),
                  const HorizontalAstronautFiguresSlider(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
