import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// general var
var demoImagePlaceHolder =
    'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
var demoProfileImageHolder =
    'https://th.bing.com/th/id/R.2fbf59259b8a109bda114b41c2d10a2d?rik=uyExTq15zo3Neg&pid=ImgRaw&r=0';

// general var

// APIs
var imagesUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=15';
List<ImageModel> fetchedImagesList = [];
// APIs

var isUserConnected;

// image picker
ImagePicker picker = ImagePicker();
File? pickedImageForProf;
File? pickedImageForPost;
// image picker

// home screen variables
var newsImageUrl =
    'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=1';
var demoNewsImageHolder =
    'https://th.bing.com/th/id/OIP.o77g1Q7GoA_ozXdDCwoABwHaEo?w=263&h=180&c=7&r=0&o=5&pid=1.7';
var imagesModelList = [];

// home screen variables

// news screen
var newsUrl = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=10';
// news screen