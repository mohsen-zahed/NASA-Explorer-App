import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';

// general var
var demoImagePlaceHolder =
    'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
var demoProfileImageHolder =
    'https://www.pngall.com/wp-content/uploads/5/Profile.png';
// general var

List<ImageModel> fetchedImagesList = [];

var isUserConnected;

// image picker
ImagePicker picker = ImagePicker();
File? pickedImageForProf;
File? pickedImageForPost;
// image picker

// home screen variables

var uid;
var userName;
var userEmail;
var userImage;

var demoNewsImageHolder =
    'https://th.bing.com/th/id/OIP.o77g1Q7GoA_ozXdDCwoABwHaEo?w=263&h=180&c=7&r=0&o=5&pid=1.7';
var imagesModelList = [];

// home screen variables

// news screen
bool isPostsLoading = true;

// news screen

//
