import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
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
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

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
  List<ImageModel> fetchedImagesList = [];

  @override
  void initState() {
    super.initState();
    fetchPlanetsFromFirebase();
    fetchTopNewsContainerData();
    fetchGalleryImagesData();
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
  }

  Future<void> fetchGalleryImagesData() async {
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

  Future<void> fetchPlanetsFromFirebase() async {
    fetchedPlanetsList.clear();
    await FirebaseFirestore.instance
        .collection("planetsData")
        .orderBy('id', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        fetchedPlanetsList.add(
          PlanetModel.create(
            element.data()['id'],
            element.data()['planetName'],
            element.data()['imageUrl'],
            element.data()['planetSubtitle'],
            element.data()['planetIntro'],
            element.data()['planetHistory'],
            element.data()['planetClimate'],
            element.data()['planetWallpaper'],
          ),
        );
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
              await fetchPlanetsFromFirebase();
              await fetchGalleryImagesData();
              getUserInfo();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  AppLogoAndProfileImage(
                    imageUrl:
                        userImage != null ? userImage : demoProfileImageHolder,
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
                    imagesList: fetchedImagesList,
                    onImagesSeeAllTap: () {
                      Navigator.pushNamed(
                        context,
                        ImageGalleryScreen.id,
                        arguments: {'title': 'Discover Perfect Images'},
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  HorizontalSolarSystemCarouselSlider(
                    planetsList: fetchedPlanetsList,
                    onSolarViewAllTap: () {
                      Navigator.pushNamed(context, SolarSystemGalleryScreen.id,
                          arguments: {
                            'planetsList': fetchedPlanetsList,
                          });
                    },
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

class SolarSystemGalleryScreen extends StatefulWidget {
  const SolarSystemGalleryScreen({super.key});
  static const String id = '/solar_system_gallery_screen';
  @override
  State<SolarSystemGalleryScreen> createState() =>
      _SolarSystemGalleryScreenState();
}

class _SolarSystemGalleryScreenState extends State<SolarSystemGalleryScreen> {
  int currentIndex = 0;
  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    List<PlanetModel> itemsList = map['planetsList'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppWidget(text: 'Solar System & The Universe'),
      body: Container(
        width: getMaxWidthMediaQuery(context),
        height: getMaxHieghtMediaQuery(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              itemsList[currentIndex].getPlanetWallpaper(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: getMaxWidthMediaQuery(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kBlackColor,
                      kBlackColor.withOpacity(0.7),
                      kBlackColor.withOpacity(.5),
                      kBlackColor.withOpacity(.3),
                      kBlackColor.withOpacity(.1),
                      kTransparentColor,
                      kTransparentColor,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 40,
              ),
              child: SizedBox(
                height: getMaxHieghtMediaQuery(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getMaxHieghtMediaQuery(context, 0.05)),
                    Expanded(
                      flex: 6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: getMaxWidthMediaQuery(context),
                          height: getMaxHieghtMediaQuery(context, 0.23),
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: .8,
                              onPageChanged: (index, reason) {},
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index, realIndex) =>
                                CachedNetworkImage(
                              imageUrl:
                                  itemsList[currentIndex].getPlanetImageUrl(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return ShimmerEffect(
                                  width: getMaxWidthMediaQuery(context),
                                  height: getMaxHieghtMediaQuery(context, 0.23),
                                );
                              },
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: getMaxWidthMediaQuery(context),
                                  height: getMaxHieghtMediaQuery(context, 0.23),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemsList[currentIndex].getPlanetName(),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    itemsList[currentIndex].getPlanetSubTitle(),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: kWhiteColor,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    itemsList[currentIndex].getPlanetIntro(),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Planet History:',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    itemsList[currentIndex].getPlanetHistory(),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Planet Climate:',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    itemsList[currentIndex].getPlanetClimate(),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: getMaxWidthMediaQuery(context),
                              height: getMaxHieghtMediaQuery(context, 0.07),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kBlackColor,
                                    kBlackColor,
                                    kBlackColor.withOpacity(0.8),
                                    kBlackColor.withOpacity(0.6),
                                    kBlackColor.withOpacity(0.4),
                                    kBlackColor.withOpacity(0.2),
                                    kBlackColor.withOpacity(0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: getMaxWidthMediaQuery(context),
                            child: CarouselSlider(
                              items: [
                                ...List.generate(
                                  itemsList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        itemsList[index].getPlanetImageUrl(),
                                      ),
                                      maxRadius: 70,
                                    ),
                                  ),
                                ),
                              ],
                              options: CarouselOptions(
                                  viewportFraction: 0.34,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.5,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
