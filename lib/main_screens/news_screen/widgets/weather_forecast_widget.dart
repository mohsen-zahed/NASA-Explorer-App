import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
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
                weatherModel?.cityName ?? 'loading city...',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                weatherModel?.mainCondition ?? 'loading condition...',
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
                '${weatherModel?.temprature.round()}°C',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 25,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              Lottie.asset(
                getWeatherAnimations(weatherModel?.mainCondition),
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
