import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/widgets/carousel/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HorizontalImagesCarouselSlider extends StatefulWidget {
  const HorizontalImagesCarouselSlider({
    super.key,
  });

  @override
  State<HorizontalImagesCarouselSlider> createState() =>
      _HorizontalImagesCarouselSliderState();
}

class _HorizontalImagesCarouselSliderState
    extends State<HorizontalImagesCarouselSlider> {
  List<String>? homeImagesList = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  void fetchImages() async {
    // try {
    var imagesResponse = await http.get(Uri.parse(imagesUrl));
    if (imagesResponse.statusCode == 200) {
      var imagesList = jsonDecode(imagesResponse.body);
      for (var x in imagesList) {
        if (x['media_type'] == 'image') {
          print(x['media_type']);
          fetchedImagesList.add(ImageModel.fromJson(x));
        } else {
          print(x['media_type']);
          continue;
        }
      }
      List<String> demoHomeImagesList = [];
      for (var i = 0; i < 5; i++) {
        demoHomeImagesList.add(fetchedImagesList[i].getUrl());
      }
      if (mounted) {
        setState(() {
          homeImagesList = demoHomeImagesList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(homeImagesList);
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
          itemCount: homeImagesList!.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                index != 0 ? 20 : 0,
                0,
                index == 5 ? 20 : 0,
                0,
              ),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: homeImagesList![index],
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  errorListener: (p0) => const Icon(Icons.error),
                  placeholder: (context, url) => Center(
                    child: Lottie.asset(
                      'assets/images/loading_image.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
