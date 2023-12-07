import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/weather_model.dart';
import 'package:nasa_explorer_app_project/services/weather_service.dart';

// general var
var demoImagePlaceHolder =
    'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
var demoProfileImageHolder =
    'https://th.bing.com/th/id/R.2fbf59259b8a109bda114b41c2d10a2d?rik=uyExTq15zo3Neg&pid=ImgRaw&r=0';
// general var

// APIs
// APIs
// APIs
var imagesUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=10';
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
var editPickedProfileImage;
var postImage;
Uri? socialMediaLink;
String developerName = 'Amir M. Zahed';
String developerEmail = 'mohsenzahed0077@gmail.com';
String developerPhone = '(+93) 797627651';
String developerIntro =
    "Hello! I'm $developerName, a passionate coder ready to bring ideas to life through the power of technology. With a strong background in coding, I thrive on solving complex problems and developing innovative solutions. Whether it's crafting elegant user interfaces, building robust databases, or creating efficient algorithms, I'm constantly driven to push the boundaries of what's possible. Join me on this exciting journey as we embark on the path of digital transformation and make a positive impact through the world of coding!";

// variables
// variables
// variables

// image picker
// image picker
ImagePicker picker = ImagePicker();
File? pickedImageForProf;
File? pickedImageForPost;

// image picker
// image picker
// image picker

// profileScreen
// profileScreen
// profileScreen
String shareText = '';
final TextEditingController profileTextEditingController =
    TextEditingController();
// profileScreen
// profileScreen
// profileScreen

String? cityName;

// home screen variables
int currentScreen = 0;
String newsContainerImageLink = '';
Future<Response>? newsContainerImageResponse;
var newsImageUrl =
    'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1';
// home screen variable

// news screen
var newsResponse;
var newsUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=5';
bool isNewsLoading = true;
bool enteredFirstTime = false;
// news screen