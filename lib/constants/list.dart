import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/models/news_post_model.dart';

List errorList = [];

List<Map<String, dynamic>> bottomNavItems = [
  {
    'title': 'Home',
    'icon': Icons.home_rounded,
    'size': 27.0,
  },
  {
    'title': 'News',
    'icon': Icons.newspaper_rounded,
    'size': 25.0,
  },
  {
    'title': '',
    'icon': Icons.add,
    'size': 45.0,
  },
  {
    'title': 'Images',
    'icon': Icons.image,
    'size': 25.0,
  },
  {
    'title': 'Settings',
    'icon': Icons.settings,
    'size': 25.0,
  },
];

List<NewsPostModel> postList = [
  NewsPostModel.createPost(
    image: [
      'assets/images/galaxy1.jpeg',
      'assets/images/bg.jpeg',
      'assets/images/bg2.jpeg',
    ],
    text:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
    userName: 'Amir Mohsen',
    profileImage: 'assets/images/armstrong.jpeg',
    postedDateYear: DateTime.now().year,
    postedDateMonth: DateTime.now().month,
    postedDateDay: DateTime.now().day,
    likesNumber: 1380,
    isLiked: false,
  ),
  NewsPostModel.createPost(
    image: [
      'assets/images/bg.jpeg',
      'assets/images/galaxy.jpeg',
    ],
    text:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
    userName: 'Salaheddin Arabi',
    profileImage: 'assets/images/profile_pic.jpeg',
    postedDateYear: DateTime.now().year,
    postedDateMonth: DateTime.now().month,
    postedDateDay: DateTime.now().day,
    likesNumber: 201,
    isLiked: false,
  ),
  NewsPostModel.createPost(
    image: [
      'assets/images/bg2.jpeg',
      'assets/images/bg.jpeg',
      'assets/images/galaxy1.jpeg',
    ],
    text:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
    userName: 'Mohammad Osman',
    profileImage: 'assets/images/profile_pic.jpeg',
    postedDateYear: DateTime.now().year,
    postedDateMonth: DateTime.now().month,
    postedDateDay: DateTime.now().day,
    likesNumber: 102,
    isLiked: false,
  ),
  NewsPostModel.createPost(
    image: [
      'assets/images/milky-way.jpg',
    ],
    text:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
    userName: 'Esmail Ebrahimi',
    profileImage: 'assets/images/armstrong.jpeg',
    postedDateYear: DateTime.now().year,
    postedDateMonth: DateTime.now().month,
    postedDateDay: DateTime.now().day,
    likesNumber: 4,
    isLiked: false,
  ),
];
