// import 'dart:typed_data';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
// import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
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
            (index) => isLoadingImages
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  )
                : Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: widget.onImageTap,
                            child: Center(
                              child: Hero(
                                tag: 'max-image',
                                child: CachedNetworkImage(
                                  imageUrl: widget.imagesList[index].getUrl(),
                                  fit: BoxFit.fill,
                                  placeholder:
                                      (BuildContext context, String url) =>
                                          Center(
                                    child: Lottie.asset(
                                      'assets/images/loading_image.json',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  errorWidget: (BuildContext context,
                                          String url, dynamic error) =>
                                      const Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 300,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: imageProvider,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: RotatedBox(
                              quarterTurns: 45,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
