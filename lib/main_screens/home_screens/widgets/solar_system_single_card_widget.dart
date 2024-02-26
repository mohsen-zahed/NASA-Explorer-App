import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class SolarSystemSinglCardWidget extends StatefulWidget {
  const SolarSystemSinglCardWidget({
    super.key,
    required this.index,
    required this.planetsList,
    required this.currentIndex,
  });
  final int index;
  final List<PlanetModel> planetsList;
  final int currentIndex;

  @override
  State<SolarSystemSinglCardWidget> createState() =>
      _SolarSystemSinglCardWidgetState();
}

class _SolarSystemSinglCardWidgetState
    extends State<SolarSystemSinglCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.index == widget.currentIndex ? 15 : 0,
        right: widget.index == widget.planetsList.length ? 0 : 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kGreyColor800,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            widget.planetsList[widget.index].getPlanetWallpaper(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Container(
              width: getMaxWidthMediaQuery(context),
              height: getMaxHieghtMediaQuery(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    kBlackColor,
                    kBlackColor.withOpacity(.7),
                    kBlackColor.withOpacity(.5),
                    kTransparentColor,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: widget.planetsList[widget.index].getPlanetImageUrl(),
              imageBuilder: (context, imageProvider) => Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => const ShimmerEffect(),
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
                  widget.planetsList[widget.index].getPlanetName(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: kWhiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  widget.planetsList[widget.index].getPlanetSubTitle(),
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
    );
  }
}
