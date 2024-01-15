
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:nasa_explorer_app_project/models/news_model.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

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
  final storage = FirebaseStorage.instance;
  String? solarImagesUrl;
  String? imageUrll = '';
  List<String>? imageUrls;
  bool userFirstTimeVisitHome = false;

  List<NewsModel> fetchedNewsList = [];

  @override
  void initState() {
    super.initState();
    getPlanetsFromFirebase();
    fetchTopNewsContainerData();
    getUserInfo();
  }

  User? user;
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
          });
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchTopNewsContainerData() async {
    await FirebaseFirestore.instance
        .collection('postsData')
        .orderBy('id', descending: false)
        .get()
        .then((value) {
      int count = value.docs.length < 3
          ? value.docs.length == 2
              ? 2
              : 1
          : 3;
      for (var i = 0; i < count; i++) {
        fetchedNewsList.add(
          NewsModel.createPost(
            image: value.docs.elementAt(i).data()['postImageUrl'],
            description: value.docs.elementAt(i).data()['postDescription'],
          ),
        );
      }

      if (mounted) {
        setState(() {
          fetchedNewsList = fetchedNewsList;
        });
      }
    });
    // print(fetchedNewsList[0].getDescription());
  }

  Future getPlanetsFromFirebase() async {
    await FirebaseFirestore.instance
        .collection("planetsData")
        .orderBy('id', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
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
      }
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: RefreshIndicator(
            onRefresh: () async {
              await fetchTopNewsContainerData();
              await getPlanetsFromFirebase();
              getUserInfo();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    AppLogoAndProfileImage(
                      imageUrl: userImage != null
                          ? userImage
                          : demoProfileImageHolder,
                      nasaLogoUrl: 'assets/images/nasa_text_logo.png',
                      onProfileImageTap: () {
                        Navigator.pushNamed(context, ProfileScreen.id);
                      },
                    ),
                    const SizedBox(height: 25),
                    const SearchField(),
                    const SizedBox(height: 15),
                    NewsContainerWidget(
                      postList: fetchedNewsList,
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
