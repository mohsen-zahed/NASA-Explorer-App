import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/add_screen/add_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/advertisement_banner_slider_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/app_logo_and_profile_image.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_astronaut_figures_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_images_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_nasa_missions_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_solar_system_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/news_container_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/search_field.dart';
import 'package:nasa_explorer_app_project/models/ad_model.dart';
import 'package:nasa_explorer_app_project/models/astronaut_model.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/nasa_missions_model.dart';
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
  bool userFirstTimeVisitHome = false;

  List<NewsModel> fetchedNewsListForTopContainer = [];
  List<ImageModel> fetchedImagesList = [];
  List<AdModel> fetchedAdsList = [];
  List<NasaMissionModel> fetchedMissionsList = [];
  List<AstronautModel> fetchedAstronautsList = [];

  @override
  void initState() {
    super.initState();
    getUserInfo();
    fetchPlanetsDataFF();
    fetchTopNewsContainerDataFF();
    fetchGalleryImagesDataFF();
    fetchAdBannerDataFF();
    fetchNasaMissionsDataFF();
  }

  void getUserInfo() async {
    try {
      User? user;
      FirebaseAuth auth = FirebaseAuth.instance;
      user = auth.currentUser;
      if (user != null) {
        uid = user.uid;
        final DocumentSnapshot userDocSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (mounted) {
          setState(() {
            userName = userDocSnapshot.get('name');
            userEmail = userDocSnapshot.get('emailAddress');
            userImage = userDocSnapshot.get('imageUrl');
            userSavedPosts = userDocSnapshot.get('savedItems');
          });
        } else {
          userName = userDocSnapshot.get('name');
          userEmail = userDocSnapshot.get('emailAddress');
          userImage = userDocSnapshot.get('imageUrl');
          userSavedPosts = userDocSnapshot.get('savedItems');
        }
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchTopNewsContainerDataFF() async {
    try {
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
          fetchedNewsListForTopContainer.add(
            NewsModel.createPost(
              image: value.docs.elementAt(i).data()['postImageUrl'],
              description: value.docs.elementAt(i).data()['postDescription'],
              postedBy: value.docs.elementAt(i).data()['postedBy'],
            ),
          );
        }

        if (mounted) {
          setState(() {
            fetchedNewsListForTopContainer = fetchedNewsListForTopContainer;
          });
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchGalleryImagesDataFF() async {
    try {
      fetchedImagesList.clear();
      await FirebaseFirestore.instance
          .collection('galleryImagesData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        int listLength = value.docs.length == 4
            ? 4
            : value.docs.length == 3
                ? 3
                : value.docs.length == 2
                    ? 2
                    : value.docs.length == 1
                        ? 1
                        : value.docs.length;
        for (var i = 0; i < listLength; i++) {
          if (value.docs.isNotEmpty) {
            fetchedImagesList.add(
              ImageModel.init(
                id: value.docs.elementAt(i).data()['id'],
                url: value.docs.elementAt(i).data()['galleryImageUrl'],
                imageDescription:
                    value.docs.elementAt(i).data()['galleryDescription'],
                date: value.docs.elementAt(i).data()['postedDate'],
                authorName: value.docs.elementAt(i).data()['authorName'],
                likesCount: value.docs.elementAt(i).data()['likesCount'],
                isLiked: value.docs.elementAt(i).data()['isLiked'],
                authorImage: value.docs.elementAt(i).data()['authorImageUrl'],
                postedBy: value.docs.elementAt(i).data()['postedBy'],
              ),
            );
          }
        }
        if (mounted) {
          setState(() {
            fetchedImagesList = fetchedImagesList;
          });
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchPlanetsDataFF() async {
    fetchedPlanetsList.clear();
    await FirebaseFirestore.instance
        .collection("planetsData")
        .orderBy('id', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        fetchedPlanetsList.add(
          PlanetModel.create(
            id: element.data()['id'],
            planetName: element.data()['planetName'],
            planetImageUrl: element.data()['imageUrl'],
            planetSubTitle: element.data()['planetSubtitle'],
            planetIntro: element.data()['planetIntro'],
            planetHistory: element.data()['planetHistory'],
            planetClimate: element.data()['planetClimate'],
            planetWallpaper: element.data()['planetWallpaper'],
            postedBy: element.data()['postedBy'],
          ),
        );
      }
    });
    if (mounted) {
      setState(() {
        fetchedPlanetsList = fetchedPlanetsList;
      });
    }
  }

  Future<void> fetchAdBannerDataFF() async {
    try {
      fetchedAdsList.clear();
      await FirebaseFirestore.instance
          .collection('AdBannerData')
          .orderBy('id', descending: false)
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            fetchedAdsList.add(
              AdModel.init(
                adImageUrl: element.data()['imageUrl'],
                adTitle: element.data()['bannerName'],
                adMessage: element.data()['bannerMessage'],
                adDescription: element.data()['bannerDescription'],
                adUrl: element.data()['bannerUrl'],
                adId: element.data()['id'],
                postedBy: element.data()['postedBy'],
              ),
            );
          }
        },
      );
      if (mounted) {
        setState(() {
          fetchedAdsList = fetchedAdsList;
        });
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchNasaMissionsDataFF() async {
    try {
      fetchedMissionsList.clear();
      await FirebaseFirestore.instance
          .collection('NasaMissionsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          fetchedMissionsList.add(
            NasaMissionModel.create(
              id: element.data()['id'],
              missionName: element.data()['missionName'],
              missionSubtitle: element.data()['missionSubtitle'],
              missionImageUrl: element.data()['imageUrl'],
              missionExplanation: element.data()['missionIntro'],
              postedDate: element.data()['postedDate'],
              postedBy: uid,
            ),
          );
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  Future<void> fetchAstronautDataFF() async {
    try {
      await FirebaseFirestore.instance
          .collection('astronautsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          fetchedAstronautsList.add(
            AstronautModel.create(
              id: element.data()['id'],
              anstronautName: element.data()['astronautName'],
              dateOfBirth: element.data()['dateOfBirth'],
              placeOfBirth: element.data()['placeOfBirth'],
              astronautBiography: element.data()['astronautBiography'],
              astronautMissions: element.data()['astronautMissions'],
              astronautImage: element.data()['astronautImageUrl'],
            ),
          );
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: RefreshIndicator(
            onRefresh: () async {
              getUserInfo();
              await fetchTopNewsContainerDataFF();
              await fetchPlanetsDataFF();
              await fetchGalleryImagesDataFF();
              await fetchAdBannerDataFF();
              await fetchNasaMissionsDataFF();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  AppLogoAndProfileImage(
                    imageUrl:
                        userImage != null ? userImage : demoProfileImageHolder,
                    nasaLogoUrl: 'assets/images/nasa_text_logo.png',
                  ),
                  const SizedBox(height: 25),
                  const SearchField(),
                  const SizedBox(height: 15),
                  NewsContainerWidget(
                    postList: fetchedNewsListForTopContainer,
                  ),
                  const SizedBox(height: 25),
                  HorizontalImagesCarouselSlider(
                    imagesList: fetchedImagesList,
                  ),
                  const SizedBox(height: 35),
                  HorizontalSolarSystemCarouselSlider(
                    planetsList: fetchedPlanetsList,
                  ),
                  const SizedBox(height: 35),
                  AdvertisementBannerSliderWidget(
                    adsList: fetchedAdsList,
                  ),
                  const SizedBox(height: 35),
                  HorizontalNASAMissionsCarouselSlider(
                    missionsList: fetchedMissionsList,
                  ),
                  const SizedBox(height: 35),
                  const HorizontalAstronautFiguresSlider(),
                ],
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
