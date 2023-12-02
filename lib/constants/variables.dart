import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';

var url = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=10';
List<ImageModel> fetchedList = [];

bool isLoadingImages = false;

bool isScreenLoading = true;
bool isFetchingDataFailed = false;
bool isMoreData = false;
var isUserConnected;
Connectivity connectivity = Connectivity();
ConnectivityResult? connectivityResult;
var pickedImage;
ImagePicker picker = ImagePicker();
File? image;
