import 'dart:io';

import 'package:image_picker/image_picker.dart';

// general var
var demoImagePlaceHolder =
    'https://th.bing.com/th/id/OIP.xjJQYPq-KlFeHuKk5BAP-AHaHa?rs=1&pid=ImgDetMain';
var demoProfileImageHolder =
    'https://www.pngall.com/wp-content/uploads/5/Profile.png';
// general var

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
List userSavedPosts = [];

var demoNewsImageHolder =
    'https://th.bing.com/th/id/OIP.o77g1Q7GoA_ozXdDCwoABwHaEo?w=263&h=180&c=7&r=0&o=5&pid=1.7';

// home screen variables

double paddingDefaultValue = 15.0;

String adKey = 'AdsList';
String missionsKey = 'MissionsList';
String galleryKey = 'GalleryList';
String planetKey = 'PlanetList';
String postKey = 'PostList';
String userKey = 'UserList';
String astKey = 'AstsList';
String newsKey = 'NewsList';

List<String> collections = [
  'AdBannerData',
  'NasaAstronautsData',
  'NasaMissionsData',
  'galleryImagesData',
  'newsBannerData',
  'postsData',
  'users',
];

List adDocsIds = [];
List astDocsIds = [];
List missionDocsIds = [];
List galleryDocsIds = [];
List newsDocsIds = [];
List postDocsIds = [];
List userDocsIds = [];
List planetDocsIds = [];
int adDocsLastNum = 0;
int astDocsLastNum = 0;
int missionDocsLastNum = 0;
int galleryDocsLastNum = 0;
int newsDocsLastNum = 0;
int postDocsLastNum = 0;
int userDocsLastNum = 0;
int planetDocsLastNum = 0;
