import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

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
                  children: [
                    SizedBox(height: getMaxHieghtMediaQuery(context, 0.05)),
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
                    Expanded(
                      flex: 8,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
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
                      child: Center(
                        child: Row(
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
                                        backgroundColor: kTransparentColor,
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
