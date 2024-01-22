import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/solar_system_single_card_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalSolarSystemCarouselSlider extends StatefulWidget {
  const HorizontalSolarSystemCarouselSlider({
    super.key,
    required this.planetsList,
    required this.onSolarViewAllTap,
  });

  final List<PlanetModel> planetsList;
  final VoidCallback onSolarViewAllTap;

  @override
  State<HorizontalSolarSystemCarouselSlider> createState() =>
      _HorizontalSolarSystemCarouselSliderState();
}

class _HorizontalSolarSystemCarouselSliderState
    extends State<HorizontalSolarSystemCarouselSlider> {
  int currentPlanet = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TitleWithViewAllButton(
            title: 'Solar System',
            onViewAllTap: widget.onSolarViewAllTap,
          ),
        ),
        const SizedBox(height: 70),
        CarouselSlider.builder(
          itemCount: widget.planetsList.length,
          itemBuilder: (context, index, realIndex) {
            return widget.planetsList.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      left: index == currentPlanet ? 15 : 10,
                      right: index == currentPlanet ? 0 : 15,
                    ),
                    child: const ShimmerEffect(),
                  )
                : SolarSystemSinglCardWidget(
                    currentIndex: currentPlanet,
                    index: index,
                    onTap: () => showSolarBottomSheet(context, index),
                    planetsList: widget.planetsList,
                  );
          },
          options: CarouselOptions(
            aspectRatio: 2.3,
            viewportFraction: .6,
            scrollPhysics: const BouncingScrollPhysics(),
            enlargeCenterPage: true,
            enlargeFactor: 0,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            clipBehavior: Clip.none,
            initialPage: 0,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentPlanet = index;
              });
            },
          ),
        ),
      ],
    );
  }

  Future<dynamic> showSolarBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      backgroundColor: kScaffoldBackgroundColor,
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          itemList: widget.planetsList,
          index: index,
        );
      },
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.itemList,
    required this.index,
  });
  final List<dynamic> itemList;
  final int index;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: getMaxHieghtMediaQuery(context, 0.9),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 230,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: PageView.builder(
                      itemCount: 3,
                      onPageChanged: (value) {
                        setState(() {
                          currentImage = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/bg.jpeg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: index == currentImage
                                ? kWhiteColor
                                : kGreyColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemList[widget.index].getPlanetName(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '- ${widget.itemList[widget.index].getPlanetSubTitle()} -',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: kWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.itemList[widget.index].getPlanetIntro(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kWhiteColor,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: kGreyColor800),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History:',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.itemList[widget.index].getPlanetHistory(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kWhiteColor,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: kGreyColor800),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Climate:',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.itemList[widget.index].getPlanetClimate(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kWhiteColor,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
