// import 'dart:typed_data';

// import 'package:cached_network_image/cached_network_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/horizontal_solar_system_carousel_slider.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/widgets/image_full_screen.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';

class VerticalImagesGridView extends StatefulWidget {
  const VerticalImagesGridView({
    super.key,
    required this.imagesList,
  });
  final List<ImageModel> imagesList;

  @override
  State<VerticalImagesGridView> createState() => _VerticalImagesGridViewState();
}

class _VerticalImagesGridViewState extends State<VerticalImagesGridView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isLoadingImages = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StaggeredGridView.count(
        crossAxisCount: 4,
        staggeredTiles: List.generate(
          widget.imagesList.length,
          (index) => const StaggeredTile.fit(2),
        ),
        children: [
          ...List.generate(
            widget.imagesList.length,
            (index) => Container(
              width: getMaxWidthMediaQuery(context),
              margin: EdgeInsets.fromLTRB(
                5,
                (index == 0 || index == 1) ? 0 : 20,
                5,
                (index == widget.imagesList.length - 1 ||
                        index == widget.imagesList.length - 2)
                    ? 15
                    : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      _showImageAuthorInfo(context, index);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageFullScreen(
                            image: widget.imagesList[index].getUrl(),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.imagesList[index].getUrl(),
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) =>
                            Center(
                          child: Lottie.asset(
                            'assets/images/loading_image.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                        errorWidget:
                            (BuildContext context, String url, dynamic error) =>
                                const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: getMaxWidthMediaQuery(context),
                            height: getMaxHieghtMediaQuery(context, 0.3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kGreyColor800,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.imagesList[index].getImageDescription(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: kWhiteColor),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.more_horiz_rounded,
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showImageAuthorInfo(BuildContext context, int index) {
    return showModalBottomSheet(
      context: context,
      barrierLabel: 'fads',
      backgroundColor: kScaffoldBackgroundColor,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: getMaxHieghtMediaQuery(context, 0.2),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          width: getMaxWidthMediaQuery(context),
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: kWhiteColor,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    widget.imagesList[index].getAuthorImage(),
                  ),
                  maxRadius: 40,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: getMaxWidthMediaQuery(context, 0.8),
                    ),
                    child: Text(
                      widget.imagesList[index].getAuthorName(),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: kWhiteColor70,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Posted on: ',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: kWhiteColor70,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: getMaxWidthMediaQuery(context, 0.5),
                        ),
                        child: Text(
                          widget.imagesList[index].getDate(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: kWhiteColor70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
