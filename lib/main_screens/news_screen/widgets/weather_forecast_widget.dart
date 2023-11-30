import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/weather_model.dart';
import 'package:nasa_explorer_app_project/services/weather_service.dart';

class WeatherForecastWidget extends StatefulWidget {
  const WeatherForecastWidget({
    super.key,
  });
  @override
  State<WeatherForecastWidget> createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {
  //apiKey
  final _weatherService = WeatherService('fa88c4230ebb702c6e7b5572e44a7095');
  WeatherModel? _weather;
  ConnectivityResult? _connectivityResult;

  // Check connectivity
  checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      checkConnectivity();
      _fetchWeather();
      getDummyData();
    } catch (e) {
      print(e);
    }
  }

  // fetch weather
  _fetchWeather() async {
    if (_connectivityResult == ConnectivityResult.none) {
      debugPrint('No internet connection available');
      return;
    }
    debugPrint('connection is available.');
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: kWhiteColor30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _weather?.cityName ?? 'loading city...',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                _weather?.mainCondition ?? 'loading condition...',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${_weather?.temprature.round()}°C',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 25,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              Lottie.asset(
                getWeatherAnimations(_weather?.mainCondition),
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
