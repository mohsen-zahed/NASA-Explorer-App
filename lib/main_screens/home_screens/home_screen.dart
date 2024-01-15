import 'dart:convert';

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
import 'package:nasa_explorer_app_project/models/post_model.dart';
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
  final storage = FirebaseStorage.instance;
  String? solarImagesUrl;
  String? imageUrll = '';
  List<String>? imageUrls;
  bool userFirstTimeVisitHome = false;

  //* news container vars
  List<PostModel> fetchedNewsList = [
    PostModel.init(
        id: 3,
        author: 'mohse',
        authorImage:
            'https://firebasestorage.googleapis.com/v0/b/nasa-explorer-app-3be03.appspot.com/o/usersImage%2Fmohse.jpeg?alt=media&token=06fb4d85-46f9-4e5b-a568-df070f67da90',
        date: '2024-1-15|14:3PM',
        explanation:
            "Innovators at NASA's Glenn Research Center have developed a breakthrough in ion thruster technology. The Annular Ion Engine (AIE) features an annular discharge chamber with a set of annular ion optics, potentially configured with a centrally mounted neutralizer cathode assembly. Compared to current state-of-the-art, cylindrically shaped ion thrusters, the AIE includes two primary advantages: 1) it enables scaling of ion thruster technology to high power at specific impulse (Isp) desirable for near-term missions, and 2) it provides a substantial increase in both thrust density and thrust-to-power (F/P) ratio. With its additional increase in lifetime service and improvements in packaging, Glenn's AIE represents the next generation of electric propulsion systems that require higher power, F/P, and efficiency, such as Solar Electric Propulsion (SEP) vehicles that may transport humans to the moon and Mars.",
        title: 'Annular Ion Engine',
        url:
            'https://firebasestorage.googleapis.com/v0/b/nasa-explorer-app-3be03.appspot.com/o/postsImages%2Fmohse-Innovators%20at.png?alt=media&token=b22bab64-697b-438f-ad8e-32a6d59643e3',
        likesCount: 0,
        isLiked: false)
  ];

  @override
  void initState() {
    super.initState();
    // fetchNewsContainerImage();
    // fetchGalleryImages();
    getPlanetsFromFirebase();
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

  Future<void> fetchPostsFromFirebase() async {
    try {
      await FirebaseFirestore.instance
          .collection('postsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (fetchedNewsList.last.getId() < element.data()['id']) {
            fetchedNewsList.add(
              PostModel.init(
                id: element.data()['id'],
                author: element.data()['author'],
                authorImage: element.data()['authorImage'],
                date: element.data()['postedDate'],
                explanation: element.data()['postDescription'],
                title: element.data()['postTitle'],
                url: element.data()['postImageUrl'],
                likesCount: element.data()['postLikesCount'],
                isLiked: element.data()['postIsLike'],
              ),
            );
          }
        }
        print(fetchedNewsList);
      });
      // newsContainerImageResponse = await http.get(Uri.parse(newsImageUrl));
      // if (newsContainerImageResponse.statusCode == 200) {
      //   newsContainerImageList = jsonDecode(newsContainerImageResponse.body);
      //   for (var x in newsContainerImageList) {
      //     fetchedNewsContainerImageList.add(ImageModel.fromJson(x));
      //   }
      //   if (mounted) {
      //     setState(() {
      //       imageUrl = fetchedNewsContainerImageList[0].getUrl();
      //     });
      //   }
      // }
    } on FirebaseException catch (e) {
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
    await FirebaseFirestore.instance
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
              await fetchPostsFromFirebase();
              // await fetchGalleryImages();
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
