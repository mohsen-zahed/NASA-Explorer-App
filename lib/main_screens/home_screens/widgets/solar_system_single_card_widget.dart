import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class SolarSystemSinglCardWidget extends StatelessWidget {
  const SolarSystemSinglCardWidget({
    super.key,
    required this.index,
    required this.onTap,
    required this.planetsList,
  });
  final int index;
  final VoidCallback onTap;
  final List<PlanetModel>? planetsList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(
          0,
          0,
          index != planetsList!.length - 1 ? 20 : 0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kGreyColor800,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: planetsList![index].getPlanetImageUrl() == ''
                  ? const ShimmerEffect(useMargin: false)
                  : Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            planetsList![index].getPlanetImageUrl(),
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planetsList![index].getPlanetName(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: kWhiteColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    planetsList![index].getPlanetSubTitle(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kWhiteColor,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
