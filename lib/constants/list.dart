import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/models/post_model.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';
import 'package:nasa_explorer_app_project/models/planet_model.dart';

List<String> errorList = [];

// List<Map<String, dynamic>> solarSystemList = [
//   {
//     'planet_name': 'Earth',
//     'planet_image': 'assets/images/earth.png',
//     'planet_subTitle': 'The Green Planet',
//     'planet_description':
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//   },
//   {
//     'planet_name': 'Mars',
//     'planet_image': 'assets/images/mars.png',
//     'planet_subTitle': 'The Minor Planet',
//     'planet_description':
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//   },
//   {
//     'planet_name': 'Moon',
//     'planet_image': 'assets/images/moon.png',
//     'planet_subTitle': 'The Night Planet',
//     'planet_description':
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//   },
// ];

List demoImages = [
  'assets/images/galaxy.jpeg',
  'assets/images/galaxy1.jpeg',
  'assets/images/advertisement_banner.jpeg',
  'assets/images/bg1.png',
  'assets/images/bg2.jpeg',
  'assets/images/milky-way.jpg',
  'assets/images/advertisement_banner.jpeg',
  'assets/images/bg1.png',
  'assets/images/bg2.jpeg',
  'assets/images/milky-way.jpg',
  'assets/images/advertisement_banner.jpeg',
  'assets/images/bg1.png',
  'assets/images/bg2.jpeg',
  'assets/images/milky-way.jpg',
  'assets/images/advertisement_banner.jpeg',
  'assets/images/bg1.png',
  'assets/images/bg2.jpeg',
  'assets/images/milky-way.jpg',
];

// List<Map<String, dynamic>> bottomNavItems = [
//   {
//     'title': 'Home',
//     'icon': Icons.home_rounded,
//     'size': 27.0,
//   },
//   {
//     'title': 'News',
//     'icon': Icons.newspaper_rounded,
//     'size': 25.0,
//   },
//   {
//     'title': '',
//     'icon': Icons.add,
//     'size': 45.0,
//   },
//   {
//     'title': 'Images',
//     'icon': Icons.image,
//     'size': 25.0,
//   },
//   {
//     'title': 'Profile',
//     'icon': Icons.person_pin,
//     'size': 25.0,
//   },
// ];

// List<NewsPostModel> demoPostList = [
//   NewsPostModel.createPost(
//     image: [
//       'assets/images/galaxy1.jpeg',
//       'assets/images/bg.jpeg',
//       'assets/images/bg2.jpeg',
//     ],
//     text:
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//     userName: 'Amir Mohsen',
//     profileImage: 'assets/images/armstrong.jpeg',
//     postedDateYear: DateTime.now().year,
//     postedDateMonth: DateTime.now().month,
//     postedDateDay: DateTime.now().day,
//     likesNumber: 1380,
//     isLiked: false,
//   ),
//   NewsPostModel.createPost(
//     image: [
//       'assets/images/bg.jpeg',
//       'assets/images/galaxy.jpeg',
//     ],
//     text:
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//     userName: 'Salaheddin Arabi',
//     profileImage: 'assets/images/profile_pic.jpeg',
//     postedDateYear: DateTime.now().year,
//     postedDateMonth: DateTime.now().month,
//     postedDateDay: DateTime.now().day,
//     likesNumber: 201,
//     isLiked: false,
//   ),
//   NewsPostModel.createPost(
//     image: [
//       'assets/images/bg2.jpeg',
//       'assets/images/bg.jpeg',
//       'assets/images/galaxy1.jpeg',
//     ],
//     text:
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//     userName: 'Mohammad Osman',
//     profileImage: 'assets/images/profile_pic.jpeg',
//     postedDateYear: DateTime.now().year,
//     postedDateMonth: DateTime.now().month,
//     postedDateDay: DateTime.now().day,
//     likesNumber: 102,
//     isLiked: false,
//   ),
//   NewsPostModel.createPost(
//     image: [
//       'assets/images/milky-way.jpg',
//     ],
//     text:
//         'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odio rem nostrum aliquam voluptatem tempora numquam dolorum dignissimos explicabo ullam alias quae, a nihil eligendi in perferendis atque quisquam. Impedit, praesentium.',
//     userName: 'Esmail Ebrahimi',
//     profileImage: 'assets/images/armstrong.jpeg',
//     postedDateYear: DateTime.now().year,
//     postedDateMonth: DateTime.now().month,
//     postedDateDay: DateTime.now().day,
//     likesNumber: 4,
//     isLiked: false,
//   ),
// ];

List<PostModel> newsPostList = [];

List<String> emptyImagesList = [
  'assets/images/loading_image.json',
  'assets/images/loading_image.json',
  'assets/images/loading_image.json',
  'assets/images/loading_image.json',
  'assets/images/loading_image.json',
];

List<String> userRegFormErrors = [];

List<PlanetModel> demoSolarFetchedPlanets = [];
List<PlanetModel> fetchedPlanets = [
  PlanetModel.create(
    1,
    'Mercury',
    'https://firebasestorage.googleapis.com/v0/b/nasa-explorer-app-3be03.appspot.com/o/planetsImages%2Fvenus.png?alt=media&token=7d83325c-8e18-4a43-b3af-e81dbd1a4ffc',
    'The Swift Messenger',
    'Mercury is the smallest planet in the Solar System and is located closest to the Sun. It is named after the Roman messenger god and is known for its extreme temperature variations. Mercury has been known since ancient times and was first observed through telescopes in the 17th century. The Mariner 10 mission provided the first close-up images of Mercury in 1974.',
    'Mercury has been observed for thousands of years, but it wasn\'t until the 1970s that a spacecraft, Mariner 10, provided close-up images of the planet. In 2011, NASA\'s MESSENGER mission provided even more detailed information about Mercury\'s surface and composition.planetHistory',
    'Due to its proximity to the Sun, Mercury experiences extreme temperature variations, with temperatures reaching up to 800 degrees Fahrenheit during the day and dropping to -290 degrees Fahrenheit at night.',
  ),
  PlanetModel.create(
    2,
    'Venus',
    'https://firebasestorage.googleapis.com/v0/b/nasa-explorer-app-3be03.appspot.com/o/planetsImages%2Fmercury.png?alt=media&token=bc1da8de-5037-483a-adb6-847beff48da8',
    'The Earth\'s Twin',
    'Venus is often referred to as Earth\'s "sister planet" due to its similar size and composition. It is known for its thick atmosphere and extremely high surface temperatures. Venus has been known since ancient times and was first visited by spacecraft in the early 1960s, with Mariner 2 being the first successful mission.',
    'Venus has been observed for centuries, with early astronomers mistaking it for a star due to its brightness. The first spacecraft to visit Venus was NASA\'s Mariner 2 in 1962, providing valuable data about its atmosphere and surface.',
    'Venus has a dense carbon dioxide atmosphere that traps heat, leading to surface temperatures that can reach up to 900 degrees Fahrenheit. It also experiences sulfuric acid rain and intense atmospheric pressure.',
  ),
];

List solarImages = [
  'earth.png',
  'jupiter.png',
  'mars.png',
  'mercury.png',
  'moon.png',
  'neptune.png',
  'pluto.png',
  'saturn.png',
  'uranus.png',
  'venus.png',
];
