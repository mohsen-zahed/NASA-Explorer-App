import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/widgets/vertical_images_grid_view.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Text(
                      'Dicover Perfect Images',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  VerticalImagesGridView(imagesList: demoImages),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
