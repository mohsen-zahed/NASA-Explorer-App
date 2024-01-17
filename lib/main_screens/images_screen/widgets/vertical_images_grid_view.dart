// import 'dart:typed_data';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';

class VerticalImagesGridView extends StatefulWidget {
  const VerticalImagesGridView({
    super.key,
    required this.imagesList,
    required this.onImageTap,
  });
  final List<ImageModel> imagesList;
  final VoidCallback onImageTap;

  @override
  State<VerticalImagesGridView> createState() => _VerticalImagesGridViewState();
}

class _VerticalImagesGridViewState extends State<VerticalImagesGridView> {
  bool isLoadingImages = false;

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
                    onTap: widget.onImageTap,
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
                        errorWidget: (BuildContext context, String url,
                                dynamic error) =>
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
}
