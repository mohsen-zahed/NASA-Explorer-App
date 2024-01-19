import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/widgets/custom_circular_progress_indicator.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});
  static const String id = '/saved_screen';

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  bool isGettingSavedList = true;

  List finalFetchedSavedPosts = [];
  @override
  void initState() {
    getUserSavedList();
    super.initState();
  }

  void getUserSavedList() async {
    try {
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
        } else {
          userSavedPosts = userDocSnapshot.get('savedItems');
        }
      }
      finalFetchedSavedPosts =
          pickSavedPosts(postsList: fetchedPostsList, postsIds: userSavedPosts);
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  List pickSavedPosts({required List postsList, required List postsIds}) {
    try {
      for (var i = 0; i < postsIds.length; i++) {
        var postId = postsIds[i];
        if (postsList.any((post) => post.getId() == postId)) {
          finalFetchedSavedPosts.add(
            postsList.firstWhere((post) => post.getId() == postId),
          );
        }
      }
      if (mounted) {
        setState(() {
          isGettingSavedList = false;
        });
      }
      return finalFetchedSavedPosts;
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.toString(), duration: 5);
      }
      return [];
    }
  }

  Future<void> removePostFromSaved(int index) async {
    try {
      setState(() {
        bookmarkedNewsToUpload.remove(finalFetchedSavedPosts[index].getId());
        finalFetchedSavedPosts.removeAt(index);
      });
      getUserSavedList();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'savedItems': bookmarkedNewsToUpload,
      });
      if (mounted) {
        setState(() {});
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    String title = map['title'];
    bool comingFromSaved = map['comingFromSaved'];
    return Scaffold(
      appBar: customAppWidget(text: title),
      body: SingleChildScrollView(
        child: isGettingSavedList
            ? const Center(
                child: CustomCircularProgressIndicator(
                  indicatorColor: kWhiteColor,
                ),
              )
            : finalFetchedSavedPosts.isNotEmpty
                ? Column(
                    children: [
                      ...List.generate(
                        finalFetchedSavedPosts.length,
                        (index) => NewsPostWidget(
                          index: index,
                          itemList: finalFetchedSavedPosts,
                          onBookmarkTapNews: () {},
                          onBookmarkTapSaved: () {
                            removePostFromSaved(index);
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: getMaxHieghtMediaQuery(context, 0.3),
                      ),
                      const Icon(
                        Icons.search,
                        size: 120,
                        color: kWhiteColor30,
                      ),
                      Text(
                        'Nothing yet!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kWhiteColor30),
                      ),
                    ],
                  ),
      ),
    );
  }
}
