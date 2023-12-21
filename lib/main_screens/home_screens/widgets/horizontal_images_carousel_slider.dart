import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class HorizontalImagesCarouselSlider extends StatefulWidget {
  const HorizontalImagesCarouselSlider({
    super.key,
    required this.imagesList,
  });
  final List? imagesList;

  @override
  State<HorizontalImagesCarouselSlider> createState() =>
      _HorizontalImagesCarouselSliderState();
}

class _HorizontalImagesCarouselSliderState
    extends State<HorizontalImagesCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Dicover Perfect Images',
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
        const SizedBox(height: 15),
        CarouselSlider.builder(
          itemCount: widget.imagesList!.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: widget.imagesList?[index] == null
                  ? ShimmerEffect(
                      useMargin: true,
                      index: index,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.imagesList![index],
                      fit: BoxFit.cover,
                      cacheManager: CacheManager(
                        Config(
                          'cached_key',
                          stalePeriod: const Duration(days: 1),
                        ),
                      ),
                      filterQuality: FilterQuality.medium,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholder: (context, url) => ShimmerEffect(
                        useMargin: true,
                        index: index,
                      ),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                            index != 0 ? 20 : 0,
                            0,
                            index == 5 ? 20 : 0,
                            0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kWhiteColor,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            );
          },
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            aspectRatio: 1.9,
            viewportFraction: 0.6,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: .4,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
          ),
        ),
      ],
    );
  }
}
