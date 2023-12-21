import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';
import 'package:shimmer/shimmer.dart';

class NewsContainerWidget extends StatefulWidget {
  const NewsContainerWidget({
    super.key,
    required this.onTap,
    required this.newsContainerBackgroundImage,
  });
  final VoidCallback onTap;
  final String? newsContainerBackgroundImage;

  @override
  State<NewsContainerWidget> createState() => _NewsContainerWidgetState();
}

class _NewsContainerWidgetState extends State<NewsContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.newsContainerBackgroundImage == null
          ? ShimmerEffect(
              width: getMaxWidthMediaQuery(context),
              height: 180,
              useMargin: false,
            )
          : CachedNetworkImage(
              imageUrl: widget.newsContainerBackgroundImage!,
              cacheManager: CacheManager(
                Config(
                  'cached_key',
                  stalePeriod: const Duration(days: 1),
                ),
              ),
              placeholder: (context, url) {
                return ShimmerEffect(
                  useMargin: false,
                  width: getMaxWidthMediaQuery(context),
                  height: 180,
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'LATEST UPDATES',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: kWhiteColor70,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: kWhiteColor70,
                                    fontSize: 9,
                                  ),
                        ),
                        Text(
                          'NASA\'s Webb Reveals Stunning New Images',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: kWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
