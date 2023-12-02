import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/models/weather_model.dart';

class WeatherService {
  static const baseURL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseURL?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('loading weather failed!');
    }
  }

  Future<String> getCurrentCity() async {
    String city = '';
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (!errorList
          .contains('You won\'t be able to use weather forecast feature!')) {
        errorList.add('You won\'t be able to use weather forecast feature!');
        print(errorList);
      }
    } else {
      if (errorList
          .contains('You won\'t be able to use weather forecast feature!')) {
        errorList.remove('You won\'t be able to use weather forecast feature!');
      }
      // get current city location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      city = placeMarks[0].locality ?? '';
      print(errorList);
    }
    return city;

    // get city name from placemarks
  }
}
