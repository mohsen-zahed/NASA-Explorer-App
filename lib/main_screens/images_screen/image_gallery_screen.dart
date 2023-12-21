import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/widgets/vertical_images_grid_view.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  bool isScreenLoading = true;
  bool isFetchingDataFailed = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
            child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  isFetchingDataFailed
                      ? const SizedBox()
                      : isScreenLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : VerticalImagesGridView(
                              imagesList: fetchedImagesList,
                              onImageTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageFullScreen(
                                      image: fetchedImagesList[index].getUrl(),
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'max-image',
            child: Image.network(image),
          ),
        ),
      ),
    );
  }
}
