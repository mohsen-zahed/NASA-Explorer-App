import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/widgets/news_post_widget.dart';

class SharedPostsScreen extends StatelessWidget {
  const SharedPostsScreen({super.key});
  static const id = '/shared_post_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0,
        title: Text(
          'Shared Posts',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kWhiteColor,
                fontSize: 19,
              ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ...List.generate(
                newsPostList.length,
                (index) => NewsPostWidget(
                  index: index,
                  itemList: newsPostList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
