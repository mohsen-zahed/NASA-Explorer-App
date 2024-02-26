import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/images_screen/image_gallery_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class HorizontalImagesCarouselSlider extends StatefulWidget {
  const HorizontalImagesCarouselSlider({
    super.key,
    required this.imagesList,
    required this.onCarouselTap,
  });
  final List<ImageModel> imagesList;
  final VoidCallback onCarouselTap;

  @override
  State<HorizontalImagesCarouselSlider> createState() =>
      _HorizontalImagesCarouselSliderState();
}

class _HorizontalImagesCarouselSliderState
    extends State<HorizontalImagesCarouselSlider> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingDefaultValue),
          child: TitleWithViewAllButton(
            title: 'Discover Perfect Images',
            onViewAllTap: () {
              Navigator.pushNamed(
                context,
                ImageGalleryScreen.id,
                arguments: {'title': 'Discover Perfect Images'},
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: widget.onCarouselTap,
          child: CarouselSlider.builder(
            itemCount: widget.imagesList.length,
            options: CarouselOptions(
              height: getMaxHieghtMediaQuery(context, 0.23),
              viewportFraction: 0.7,
              enlargeFactor: 0.2,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentImage = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) => Padding(
              padding: EdgeInsets.only(
                left: index == currentImage ? 15 : 0,
                right: index == widget.imagesList.length ? 0 : 15,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: widget.imagesList.isEmpty
                    ? ShimmerEffect(
                        width: getMaxWidthMediaQuery(context),
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.imagesList[index].getUrl(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) {
                          return Container(
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ExtendedImage.network(
//     widget.imagesList![index],
//     fit: BoxFit.cover,
//     loadStateChanged: (ExtendedImageState state) {
//       switch (state.extendedImageLoadState) {
//         case LoadState.loading:
//           return Center(
//             child: ShimmerEffect(
//               useMargin: true,
//               index: index,
//             ),
//           );
//         case LoadState.completed:
//           return Container(
//             margin: EdgeInsets.fromLTRB(
//               index != 0 ? 20 : 0,
//               0,
//               index == 5 ? 20 : 0,
//               0,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: kScaffoldBackgroundColor,
//               image: DecorationImage(
//                 image: ExtendedNetworkImageProvider(
//                   widget.imagesList![index],
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         case LoadState.failed:
//           return const Center(
//             child: Icon(
//               Icons.error_outline,
//               size: 70,
//               color: kWhiteColor30,
//             ),
//           );
//         default:
//           return null;
//       }
//     },
//   ),
