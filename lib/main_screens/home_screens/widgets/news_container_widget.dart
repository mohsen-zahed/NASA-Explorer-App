import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

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
          : ExtendedImage.network(
              widget.newsContainerBackgroundImage!,
              fit: BoxFit.cover,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Center(
                      child: ShimmerEffect(
                        useMargin: false,
                        height: 180,
                        width: getMaxWidthMediaQuery(context),
                      ),
                    );
                  case LoadState.completed:
                    return Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: kScaffoldBackgroundColor,
                        image: DecorationImage(
                          image: ExtendedNetworkImageProvider(
                              widget.newsContainerBackgroundImage!),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: kWhiteColor70,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: kWhiteColor70,
                                    fontSize: 9,
                                  ),
                            ),
                            Text(
                              'NASA\'s Webb Reveals Stunning New Images',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: kWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case LoadState.failed:
                    return const Center(
                      child: Icon(Icons.error_outline),
                    );
                  default:
                    return null;
                }
              },
            ),

      // CachedNetworkImage(
      //     key: UniqueKey(),
      //     imageUrl: widget.newsContainerBackgroundImage!,
      //     cacheManager: CacheManager(
      //       Config(
      //         'cached_key',
      //         stalePeriod: const Duration(days: 1),
      //       ),
      //     ),
      //     placeholder: (context, url) {
      //       return ShimmerEffect(
      //         useMargin: false,
      //         width: getMaxWidthMediaQuery(context),
      //         height: 180,
      //       );
      //     },
      //     imageBuilder: (context, imageProvider) {
      //       return
      //     },
      //   ),
    );
  }
}
