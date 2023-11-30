
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // get current city location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // get city name from placemarks
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String city = placeMarks[0].locality ?? '';
    return city;
  }
}
