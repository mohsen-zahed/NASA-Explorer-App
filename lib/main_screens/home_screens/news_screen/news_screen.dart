import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/widgets/weather_forecast_widget.dart';
import 'package:nasa_explorer_app_project/models/post_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_circular_progress_indicator.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    super.key,
  });
  static const id = '/news_screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isPostsLoading = true;
  @override
  void initState() {
    super.initState();
    fetchPostsFromFirebase();
  }

  Future<void> getSavedPosts() async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
    if (user != null) {
      uid = user.uid;
      final DocumentSnapshot userDocSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (mounted) {
        setState(() {
          userSavedPosts = userDocSnapshot.get('savedItems');
        });
      }
    }
  }

  Future<void> fetchPostsFromFirebase() async {
    try {
      fetchedPostsList.clear();
      await FirebaseFirestore.instance
          .collection('postsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) async {
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
        await getSavedPosts();
        if (mounted) {
          setState(() {
            isPostsLoading = false;
          });
        }
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

  Future<void> onBookmarkTap(int index) async {
    try {
      if (!bookmarkedNewsToUpload.contains(fetchedPostsList[index].getId())) {
        setState(() {
          bookmarkedNewsToUpload.add(fetchedPostsList[index].getId());
        });
        getSavedPosts();
        if (mounted) {
          showSnackBar(
              context: context, text: 'Post added to Saved List', duration: 2);
        }
      } else {
        setState(() {
          bookmarkedNewsToUpload.remove(fetchedPostsList[index].getId());
        });
        getSavedPosts();
        if (mounted) {
          showSnackBar(
              context: context,
              text: 'Post removed from Saved List',
              duration: 2);
        }
      }
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'savedItems': bookmarkedNewsToUpload,
      });
      getSavedPosts();
    } on FirebaseException catch (e) {
      if (mounted) {
        setState(() {
          bookmarkedNewsToUpload.remove(fetchedPostsList[index].getId());
        });
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
                  const WeatherForecastWidget(),
                  const SizedBox(height: 10),
                  isPostsLoading
                      ? const Center(
                          child: CustomCircularProgressIndicator(
                            indicatorColor: kWhiteColor,
                          ),
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
                                        onBookmarkTapNews: () {
                                          onBookmarkTap(index);
                                        }),
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
