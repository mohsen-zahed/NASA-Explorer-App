import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/weather_forecast_widget.dart';
import 'package:nasa_explorer_app_project/models/post_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    super.key,
  });
  static const id = '/news_screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    fetchPostsFromFirebase();
  }

  Future<void> fetchPostsFromFirebase() async {
    try {
      fetchedPostsList.clear();
      await FirebaseFirestore.instance
          .collection('postsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          fetchedPostsList.add(
            PostModel.init(
              id: element.data()['id'],
              author: element.data()['author'],
              authorImage: element.data()['authorImage'],
              date: element.data()['postedDate'],
              explanation: element.data()['postDescription'],
              title: element.data()['postTitle'],
              url: element.data()['postImageUrl'],
              likesCount: element.data()['postLikesCount'],
              isLiked: element.data()['postIsLike'],
              isPostSaved: element.data()['isPostSaved'],
            ),
          );
        }
        if (mounted) {
          setState(() {
            isPostsLoading = false;
          });
        }
        print(fetchedPostsList);
      });
      // newsContainerImageResponse = await http.get(Uri.parse(newsImageUrl));
      // if (newsContainerImageResponse.statusCode == 200) {
      //   newsContainerImageList = jsonDecode(newsContainerImageResponse.body);
      //   for (var x in newsContainerImageList) {
      //     fetchedNewsContainerImageList.add(ImageModel.fromJson(x));
      //   }
      //   if (mounted) {
      //     setState(() {
      //       imageUrl = fetchedNewsContainerImageList[0].getUrl();
      //     });
      //   }
      // }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppWidget(text: 'Latest Updates From NASA+'),
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      await fetchPostsFromFirebase();
                    },
                    child: const WeatherForecastWidget(),
                  ),
                  const SizedBox(height: 10),
                  isPostsLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RefreshIndicator(
                          onRefresh: () => fetchPostsFromFirebase(),
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 185,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ...List.generate(
                                    fetchedPostsList.length,
                                    (index) => NewsPostWidget(
                                      index: index,
                                      itemList: fetchedPostsList,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  // const SizedBox(height: 65)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
