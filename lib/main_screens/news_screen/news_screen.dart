import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/news_post_widget.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/widgets/weather_forecast_widget.dart';
import 'package:nasa_explorer_app_project/widgets/background_image_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  static const id = '/news_screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    try {
      _fetchWeather();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('failed to update weather forecast'),
        ),
      );
    }
  }

  // fetch weather
  _fetchWeather() async {
    if (isUserConnected == false) {
      debugPrint('failed to connect to internet');
      return;
    }

    debugPrint('connection is available.');

    // get weather for city
    try {
      // get the current city
      String cityName = await weatherService.getCurrentCity();
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        weatherModel = weather;
      });
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
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
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 155,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(
                          postList.length,
                          (index) => NewsPostWidget(
                            index: index,
                            itemList: postList,
                          ),
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
