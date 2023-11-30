import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class VerticalImagesGridView extends StatelessWidget {
  const VerticalImagesGridView({
    super.key,
    required this.imagesList,
  });
  final List imagesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StaggeredGridView.count(
        crossAxisCount: 4,
        staggeredTiles: List.generate(
          imagesList.length,
          (index) => const StaggeredTile.fit(2),
        ),
        children: [
          ...List.generate(
            imagesList.length,
            (index) => Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Image.asset(
                      imagesList[index],
                      fit: BoxFit.cover,
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
