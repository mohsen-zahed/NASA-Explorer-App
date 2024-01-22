import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/models/nasa_missions_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class HorizontalNASAMissionsCarouselSlider extends StatefulWidget {
  const HorizontalNASAMissionsCarouselSlider({
    super.key,
    required this.missionsList,
  });
  final List<NasaMissionModel> missionsList;

  @override
  State<HorizontalNASAMissionsCarouselSlider> createState() =>
      _HorizontalNASAMissionsCarouselSliderState();
}

class _HorizontalNASAMissionsCarouselSliderState
    extends State<HorizontalNASAMissionsCarouselSlider> {
  int currentMission = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingDefaultValue),
          child: TitleWithViewAllButton(
            title: 'NASA Missions',
            onViewAllTap: () {},
          ),
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: widget.missionsList.length,
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            aspectRatio: 2.3,
            viewportFraction: 0.65,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: .5,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentMission = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return widget.missionsList.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      left: index == currentMission ? 15 : 10,
                      right: index == currentMission ? 0 : 15,
                    ),
                    child: const ShimmerEffect(),
                  )
                : CachedNetworkImage(
                    imageUrl: widget.missionsList[index].getMissionImageUrl(),
                    placeholder: (context, url) => Padding(
                      padding: EdgeInsets.only(
                        left: index == currentMission ? 15 : 10,
                        right: index == currentMission ? 0 : 15,
                      ),
                      child: const ShimmerEffect(),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      margin: EdgeInsets.fromLTRB(
                        currentMission == index ? 15 : 0,
                        0,
                        currentMission == index ? 10 : 0,
                        0,
                      ),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  kBlackColor,
                                  kBlackColor.withOpacity(0.8),
                                  kBlackColor.withOpacity(0.7),
                                  kBlackColor.withOpacity(0.5),
                                  kBlackColor.withOpacity(0.3),
                                  kBlackColor.withOpacity(0.1),
                                  kTransparentColor,
                                  kTransparentColor,
                                  kTransparentColor,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 25,
                            bottom: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 185),
                                  child: Text(
                                    widget.missionsList[index].getMissionName(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 175),
                                  child: Text(
                                    widget.missionsList[index]
                                        .getMissionSubtitle(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontSize: 10,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
