import 'package:nasa_explorer_app_project/models/astronaut_model.dart';
import 'package:nasa_explorer_app_project/models/image_model.dart';
import 'package:nasa_explorer_app_project/models/post_model.dart';
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
List<PlanetModel> fetchedPlanetsList = [];

List<PostModel> fetchedPostsList = [];

List<int> bookmarkedNewsToUpload = [];

List<ImageModel> fetchedImagesList = [];

List<AstronautModel> fetchedAstrnautsList2 = [];

var imagesModelList = [];

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
