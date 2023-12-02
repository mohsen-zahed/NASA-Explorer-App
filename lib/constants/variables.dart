import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/weather_model.dart';
import 'package:nasa_explorer_app_project/services/weather_service.dart';

// APIs
// APIs
// APIs
var url = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=10';
List<ImageModel> fetchedList = [];
// APIs
// APIs
// APIs

// weather apiKey
// weather apiKey
final weatherService = WeatherService('fa88c4230ebb702c6e7b5572e44a7095');
WeatherModel? weatherModel;
// weather apiKey
// weather apiKey
// weather apiKey

// connectivity
// connectivity
// connectivity
Connectivity connectivity = Connectivity();
ConnectivityResult? connectivityResult;
// connectivity
// connectivity
// connectivity

// variables
// variables
bool isLoadingImages = false;
bool isScreenLoading = true;
bool isFetchingDataFailed = false;
bool isMoreData = false;
var isUserConnected;
var pickedImage;
// variables
// variables
// variables

// image picker
// image picker
ImagePicker picker = ImagePicker();
File? image;
// image picker
// image picker
// image picker
