import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/solar_system_single_card_widget.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';

class HorizontalSolarSystemCarouselSlider extends StatefulWidget {
  const HorizontalSolarSystemCarouselSlider({
    super.key,
  });

  @override
  State<HorizontalSolarSystemCarouselSlider> createState() =>
      _HorizontalSolarSystemCarouselSliderState();
}

class _HorizontalSolarSystemCarouselSliderState
    extends State<HorizontalSolarSystemCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Solar System',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kWhiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    'All',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: kWhiteColor,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kWhiteColor,
                    size: 12,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 70),
        CarouselSlider.builder(
          itemCount: solarSystemList.length,
          itemBuilder: (context, index, realIndex) {
            return SolarSystemSinglCardWidget(
              index: index,
              solarList: solarSystemList,
              onTap: () => showSolarBottomSheet(context, index),
            );
          },
          options: CarouselOptions(
            aspectRatio: 2.4,
            viewportFraction: 0.5,
            scrollPhysics: const BouncingScrollPhysics(),
            enlargeCenterPage: true,
            enlargeFactor: .4,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            clipBehavior: Clip.none,
            initialPage: 0,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
          ),
        ),
      ],
    );
  }

  Future<dynamic> showSolarBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: kBackgroundColor,
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          itemList: solarSystemList,
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
  final List<Map<String, dynamic>> itemList;
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
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      widget.itemList[widget.index]['planet_name'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.itemList[widget.index]['planet_description'],
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
                      'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
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
                      'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kWhiteColor,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
