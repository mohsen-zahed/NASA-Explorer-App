import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';
import 'package:nasa_explorer_app_project/models/post_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class NewsContainerWidget extends StatefulWidget {
  const NewsContainerWidget({
    super.key,
    required this.onTap,
    required this.postList,
  });
  final VoidCallback onTap;
  final List<NewsModel> postList;

  @override
  State<NewsContainerWidget> createState() => _NewsContainerWidgetState();
}

class _NewsContainerWidgetState extends State<NewsContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.postList.isEmpty
          ? ShimmerEffect(
              width: getMaxWidthMediaQuery(context),
              height: getMaxHieghtMediaQuery(context, 0.23),
              useMargin: false,
            )
          : SizedBox(
              width: getMaxWidthMediaQuery(context),
              height: getMaxHieghtMediaQuery(context, 0.23),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CachedNetworkImage(
                  imageUrl: widget.postList[0].getImage(),
                  placeholder: (context, url) {
                    return ShimmerEffect(
                      useMargin: false,
                      width: getMaxWidthMediaQuery(context),
                      height: getMaxHieghtMediaQuery(context, 0.23),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: getMaxWidthMediaQuery(context),
                      height: getMaxHieghtMediaQuery(context, 0.23),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: getMaxWidthMediaQuery(context),
                              height: getMaxHieghtMediaQuery(context, 0.23),
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
                          Padding(
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
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        getMaxWidthMediaQuery(context, 0.9),
                                    maxHeight: 50,
                                  ),
                                  child: Text(
                                    widget.postList[0].getDescription(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: kWhiteColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

// ExtendedImage.network(
//               widget.postList[0].getImage(),
//               fit: BoxFit.cover,
//               loadStateChanged: (ExtendedImageState state) {
//                 switch (state.extendedImageLoadState) {
//                   case LoadState.loading:
//                     return Center(
//                       child: ShimmerEffect(
//                         useMargin: false,
//                         height: 180,
//                         width: getMaxWidthMediaQuery(context),
//                       ),
//                     );
//                   case LoadState.completed:
//                     return Container(
//                       width: double.infinity,
//                       height: 180,
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(15),
//                         ),
//                         color: kScaffoldBackgroundColor,
//                         image: DecorationImage(
//                           image: ExtendedNetworkImageProvider(
//                             widget.postList[0].getImage(),
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 25,
//                           vertical: 25,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               'LATEST UPDATES',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                     color: kWhiteColor70,
//                                     decoration: TextDecoration.underline,
//                                     decorationThickness: 2,
//                                     decorationColor: kWhiteColor70,
//                                     fontSize: 9,
//                                   ),
//                             ),
//                             ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 maxWidth: getMaxWidthMediaQuery(context, 0.9),
//                                 maxHeight: 50,
//                               ),
//                               child: Text(
//                                 widget.postList[0].getDescription(),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .copyWith(
//                                       color: kWhiteColor,
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   case LoadState.failed:
//                     return const Center(
//                       child: Icon(Icons.error_outline),
//                     );
//                   default:
//                     return null;
//                 }
//               },
//             ),
    );
  }
}
