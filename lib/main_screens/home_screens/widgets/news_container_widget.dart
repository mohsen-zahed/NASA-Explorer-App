import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';
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
  int currentNewsPage = 0;

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
          : Column(
              children: [
                SizedBox(
                  width: getMaxWidthMediaQuery(context),
                  height: getMaxHieghtMediaQuery(context, 0.23),
                  child: PageView.builder(
                    itemCount: 3,
                    onPageChanged: (value) {
                      setState(() {
                        currentNewsPage = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CachedNetworkImage(
                      imageUrl: widget.postList[index].getImage(),
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
                                            decoration:
                                                TextDecoration.underline,
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
                                      child: DefaultTextStyle(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: kWhiteColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              cursor: '..|',
                                              speed: const Duration(
                                                milliseconds: 90,
                                              ),
                                              widget.postList[index]
                                                  .getDescription(),
                                            ),
                                          ],
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
                const SizedBox(height: 4),
                SizedBox(
                  width: getMaxWidthMediaQuery(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 1.5,
                              margin: const EdgeInsets.only(right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: currentNewsPage == index
                                    ? kWhiteColor
                                    : kWhiteColor30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

// ExtendedImage.network(
//               widget.postList[index].getImage(),
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
//                             widget.postList[index].getImage(),
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
//                                 widget.postList[index].getDescription(),
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
