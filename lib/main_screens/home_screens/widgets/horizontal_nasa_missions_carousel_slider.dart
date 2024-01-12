import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_options.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';

class HorizontalNASAMissionsCarouselSlider extends StatelessWidget {
  const HorizontalNASAMissionsCarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithViewAllButton(
          title: 'NASA Missions',
          onViewAllTap: () {},
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.fromLTRB(
                0,
                0,
                index != 5 ? 10 : 0,
                0,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/images/bg1.png'),
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
                          kBlackColor.withOpacity(0.1),
                          kWhiteColor.withOpacity(0.075),
                          kWhiteColor.withOpacity(0.1),
                          kWhiteColor.withOpacity(0.15),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
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
                          constraints: const BoxConstraints(maxWidth: 185),
                          child: Text(
                            'APOLLO 11',
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
                          constraints: const BoxConstraints(maxWidth: 175),
                          child: Text(
                            'a mission to start exploring the universe for the first time.',
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
            );
          },
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            aspectRatio: 2.3,
            viewportFraction: 0.65,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: .5,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
          ),
        ),
      ],
    );
  }
}
