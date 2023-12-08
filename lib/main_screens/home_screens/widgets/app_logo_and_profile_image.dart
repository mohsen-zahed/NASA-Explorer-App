import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class AppLogoAndProfileImage extends StatelessWidget {
  const AppLogoAndProfileImage({
    super.key,
    required this.imageUrl,
    required this.nasaLogoUrl,
  });
  final String imageUrl;
  final String nasaLogoUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(nasaLogoUrl, scale: 50),
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
