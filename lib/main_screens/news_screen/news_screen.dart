import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/weather_forecast_widget.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  
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
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 155,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(
                          postList.length,
                          (index) => NewsPostWidget(index: index),
                        ),
                      ],
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
