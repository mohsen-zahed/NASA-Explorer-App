import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/advertisement_banner_slider_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/app_logo_and_profile_image.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_astronaut_figures_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_images_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_nasa_missions_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_solar_system_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/news_container_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/search_field.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    fetchNewsContainerImage();
  }

  Future<void> fetchNewsContainerImage() async {
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
  }

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
                    newsContainerBackgroundImage:
                        imageUrl ?? demoNewsImageHolder,
                    onTap: () {},
                  ),
                  const SizedBox(height: 25),
                  HorizontalImagesCarouselSlider(),
                  const SizedBox(height: 35),
                  const HorizontalSolarSystemCarouselSlider(),
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
