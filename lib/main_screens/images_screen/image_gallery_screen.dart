import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/widgets/vertical_images_grid_view.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});
  static const String id = '/gallery_screen';

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  @override
  void initState() {
    super.initState();
    fetchGalleryImagesData();
  }

  bool isScreenLoading = true;
  bool isFetchingDataFailed = false;
  List<ImageModel> fetchedAllImagesList = [];

  Future<void> fetchGalleryImagesData() async {
    try {
      fetchedAllImagesList.clear();
      await FirebaseFirestore.instance
          .collection('galleryImagesData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (value.docs.isNotEmpty) {
            fetchedAllImagesList.add(
              ImageModel.init(
                id: element.data()['id'],
                url: element.data()['galleryImageUrl'],
                imageDescription: element.data()['galleryDescription'],
                date: element.data()['postedDate'],
                authorName: element.data()['authorName'],
                likesCount: element.data()['likesCount'],
                isLiked: element.data()['isLiked'],
                authorImage: element.data()['authorImageUrl'],
              ),
            );
          }
        }
        if (mounted) {
          setState(() {
            fetchedAllImagesList = fetchedAllImagesList;
            isScreenLoading = false;
          });
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    } finally {
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    String title = map['title'];
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
            child: ListView.builder(
          itemCount: fetchedAllImagesList.length,
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
                      title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: kWhiteColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  isScreenLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : VerticalImagesGridView(
                          imagesList: fetchedAllImagesList,
                          onImageTap: () {
                            print(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageFullScreen(
                                  image: fetchedAllImagesList[index].getUrl(),
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
          child: CachedNetworkImage(
            imageUrl: image,
            cacheManager: CacheManager(
              Config(
                'cacheKey',
                stalePeriod: const Duration(hours: 1),
              ),
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
