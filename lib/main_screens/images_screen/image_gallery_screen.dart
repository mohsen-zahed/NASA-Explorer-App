import 'dart:convert';

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
  final _controller = ScrollController();
  bool _isMoreData = false;
  @override
  void initState() {
    super.initState();
    try {
      setState(() {
        isScreenLoading = true;
        fetchImages();
        isScreenLoading = false;
      });
    } catch (e) {
      setState(() {
        isScreenLoading = false;
        isFetchingDataFailed = true;
      });
      print(e);
    }
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        fetchImages();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
            child: ListView.builder(
          itemCount: fetchedList.length + 1,
          controller: _controller,
          itemBuilder: (context, index) {
            if (index < fetchedList.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
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
                                imagesList: fetchedList,
                                onImageTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageFullScreen(
                                        image: fetchedList[index].getUrl(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ],
                ),
              );
            } else {
              return _isMoreData == true
                  ? const Center(
                      child: Text(
                      "No More Dara",
                    ))
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
            }
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
