import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class HorizontalImagesCarouselSlider extends StatefulWidget {
  const HorizontalImagesCarouselSlider({
    super.key,
    required this.imagesList,
    required this.onImagesSeeAllTap,
  });
  final List? imagesList;
  final VoidCallback onImagesSeeAllTap;

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
        TitleWithViewAllButton(
          title: 'Discover Perfect Images',
          onViewAllTap: widget.onImagesSeeAllTap,
        ),
        const SizedBox(height: 10),
        CarouselSlider.builder(
          key: UniqueKey(),
          itemCount: widget.imagesList!.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index != widget.imagesList!.length ? 0 : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: widget.imagesList!.isEmpty
                    ? ShimmerEffect(
                        useMargin: true,
                        index: index,
                      )
                    : ExtendedImage.network(
                        widget.imagesList![index],
                        fit: BoxFit.cover,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return Center(
                                child: ShimmerEffect(
                                  useMargin: true,
                                  index: index,
                                ),
                              );
                            case LoadState.completed:
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                  index != 0 ? 20 : 0,
                                  0,
                                  index == 5 ? 20 : 0,
                                  0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kScaffoldBackgroundColor,
                                  image: DecorationImage(
                                    image: ExtendedNetworkImageProvider(
                                      widget.imagesList![index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            case LoadState.failed:
                              return const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 70,
                                  color: kWhiteColor30,
                                ),
                              );
                            default:
                              return null;
                          }
                        },
                      ),
                // CachedNetworkImage(
                //     imageUrl: widget.imagesList![index],
                //     key: UniqueKey(),
                //     fit: BoxFit.cover,
                //     cacheManager: CacheManager(
                //       Config(
                //         'cached_key',
                //         stalePeriod: const Duration(days: 1),
                //       ),
                //     ),
                //     filterQuality: FilterQuality.medium,
                //     errorWidget: (context, url, error) =>
                //         const Icon(Icons.error),
                //     placeholder: (context, url) => ShimmerEffect(
                //       useMargin: true,
                //       index: index,
                //     ),
                //     imageBuilder: (context, imageProvider) {
                //       return Container(
                //         margin: EdgeInsets.fromLTRB(
                //           index != 0 ? 20 : 0,
                //           0,
                //           index == 5 ? 20 : 0,
                //           0,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15),
                //           color: kWhiteColor,
                //           image: DecorationImage(
                //             image: imageProvider,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
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
