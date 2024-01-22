import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/ad_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class AdvertisementBannerSliderWidget extends StatefulWidget {
  const AdvertisementBannerSliderWidget({
    super.key,
    required this.adsList,
  });
  final List<AdModel> adsList;

  @override
  State<AdvertisementBannerSliderWidget> createState() =>
      _AdvertisementBannerSliderWidgetState();
}

class _AdvertisementBannerSliderWidgetState
    extends State<AdvertisementBannerSliderWidget> {
  int currentAd = 0;
  String adTitle = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: paddingDefaultValue),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: kGreyColor800,
            borderRadius: BorderRadius.circular(15),
          ),
          child: widget.adsList.isEmpty
              ? ShimmerEffect(
                  height: getMaxHieghtMediaQuery(context, 0.2),
                )
              : Banner(
                  message: widget.adsList[currentAd].getAdMessage(),
                  location: BannerLocation.topEnd,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: getMaxWidthMediaQuery(context),
                          height: getMaxHieghtMediaQuery(context, 0.2),
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval:
                                  const Duration(milliseconds: 20000),
                              autoPlayCurve: Curves.easeInOut,
                              scrollPhysics: const BouncingScrollPhysics(),
                              enableInfiniteScroll: true,
                              initialPage: 0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentAd = index;
                                });
                              },
                            ),
                            itemCount: widget.adsList.length,
                            itemBuilder: (context, index, realIndex) {
                              adTitle = joinWords(
                                text: widget.adsList[index].getAdDescription(),
                                end: 6,
                              );
                              currentAd = index;
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  currentAd == index ? 0 : 10,
                                  0,
                                  0,
                                  0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.adsList[currentAd]
                                        .getAdImageUrl(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: getMaxWidthMediaQuery(context),
                                      height: getMaxHieghtMediaQuery(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        ShimmerEffect(
                                      width: getMaxHieghtMediaQuery(context),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: getMaxWidthMediaQuery(context),
                                child: Text(
                                  adTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: getMaxHieghtMediaQuery(context, 0.04),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 4,
                              ),
                              child: ElevatedButton(
                                onPressed: () => redirectToAdUrl(
                                  context: context,
                                  link: widget.adsList[currentAd].getAdUrl(),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Read more',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: kBlackColor),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: kBlackColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: getMaxWidthMediaQuery(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                ...List.generate(
                  widget.adsList.length,
                  (index) => Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 1.5,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: currentAd == index ? kWhiteColor : kWhiteColor30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // AnimatedContainer adSliderIndicator({required int index}) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     width: index == currentAd ? 18 : 10,
  //     height: 3,
  //     margin: const EdgeInsets.only(right: 3),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(50),
  //       color: index == currentAd ? kWhiteColor : kWhiteColor70,
  //     ),
  //   );
  // }
}
