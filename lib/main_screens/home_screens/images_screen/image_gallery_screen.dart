import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/images_screen/widgets/vertical_images_grid_view.dart';
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
      if (mounted) {
        setState(() {
          isScreenLoading = false;
        });
      }
    }
  }

  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    String title = map['title'];
    return Scaffold(
      appBar: customAppWidget(text: title),
      body: BackgroundImageWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isScreenLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : VerticalImagesGridView(
                    imagesList: fetchedAllImagesList,
                  ),
          ),
        ),
      ),
    );
  }
}
