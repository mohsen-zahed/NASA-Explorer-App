import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/custom_circular_progress_indicator.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class SolarSystemGalleryScreen extends StatefulWidget {
  const SolarSystemGalleryScreen({super.key});
  static const String id = '/solar_system_gallery_screen';
  @override
  State<SolarSystemGalleryScreen> createState() =>
      _SolarSystemGalleryScreenState();
}

class _SolarSystemGalleryScreenState extends State<SolarSystemGalleryScreen> {
  List<PlanetModel> planetsList = [];

  Future<void> fetchPlanetsData() async {
    try {
      planetsList.clear();
      await FirebaseFirestore.instance
          .collection("planetsData")
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          planetsList.add(
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
        if (mounted) {
          setState(() {
            planetsList = planetsList;
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlanetsData();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppWidget(text: 'Solar System & The Universe'),
      body: 
      planetsList.isEmpty
          ? const Center(
              child:
                  CustomCircularProgressIndicator(indicatorColor: kWhiteColor),
            )
          :
           Container(
              width: getMaxWidthMediaQuery(context),
              height: getMaxHieghtMediaQuery(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    planetsList[currentIndex].getPlanetWallpaper(),
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
                        children: [
                          SizedBox(
                              height: getMaxHieghtMediaQuery(context, 0.05)),
                          Expanded(
                            flex: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  viewportFraction: .8,
                                  onPageChanged: (index, reason) {},
                                ),
                                itemCount: 3,
                                itemBuilder: (context, index, realIndex) =>
                                    CachedNetworkImage(
                                  imageUrl: planetsList[currentIndex]
                                      .getPlanetImageUrl(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return ShimmerEffect(
                                      width: getMaxWidthMediaQuery(context),
                                      height:
                                          getMaxHieghtMediaQuery(context, 0.23),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: getMaxWidthMediaQuery(context),
                                      height:
                                          getMaxHieghtMediaQuery(context, 0.23),
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
                          Expanded(
                            flex: 8,
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          planetsList[currentIndex]
                                              .getPlanetName(),
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
                                          planetsList[currentIndex]
                                              .getPlanetSubTitle(),
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
                                          planetsList[currentIndex]
                                              .getPlanetIntro(),
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
                                          planetsList[currentIndex]
                                              .getPlanetHistory(),
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
                                          planetsList[currentIndex]
                                              .getPlanetClimate(),
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
                                    height:
                                        getMaxHieghtMediaQuery(context, 0.07),
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
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: getMaxWidthMediaQuery(context),
                                    child: CarouselSlider(
                                      items: [
                                        ...List.generate(
                                          planetsList.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                planetsList[index]
                                                    .getPlanetImageUrl(),
                                              ),
                                              backgroundColor:
                                                  kTransparentColor,
                                              maxRadius: 70,
                                            ),
                                          ),
                                        ),
                                      ],
                                      options: CarouselOptions(
                                          viewportFraction: 0.36,
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
