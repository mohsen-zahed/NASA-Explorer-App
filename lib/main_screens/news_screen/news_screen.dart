import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/weather_forecast_widget.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';
import 'package:http/http.dart' as http;

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
    if (!enteredFirstTime) {
      fetchNewsPosts();
    }
  }

  Future<List<NewsModel>> fetchNewsPosts() async {
    newsResponse = await http.get(Uri.parse(newsUrl));
    var fetchedNewsPostsList = [];
    if (newsResponse.statusCode == 200) {
      try {
        fetchedNewsPostsList = jsonDecode(newsResponse.body);
        for (var x in fetchedNewsPostsList) {
          newsPostList.add(NewsModel.fromJson(x));
          for (var i = 0; i < newsPostList.length; i++) {
            print(newsPostList[i].getCopyRight());
          }
        }
        setState(() {
          isNewsLoading = false;
          enteredFirstTime = true;
        });
        return newsPostList;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return newsPostList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const WeatherForecastWidget(),
                const SizedBox(height: 20),
                isNewsLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => fetchNewsPosts(),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 155,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
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
                      ),
                // const SizedBox(height: 65)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
