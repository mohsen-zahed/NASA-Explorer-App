import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/initial_screens/splash_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/add_screen/add_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/images_screen/image_gallery_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/news_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/saved_posts_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/solar_system_gallery_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/profile_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/profile_image_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/profile_screen/sub_screens/shared_posts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAbLIQyIKyAaBViUdokKPCw_u8E3tSFGMI',
      appId: '1:259386221113:android:dcf07517642fb78548a3e8',
      projectId: 'nasa-explorer-app-3be03',
      messagingSenderId: '',
      storageBucket: "nasa-explorer-app-3be03.appspot.com",
    ),
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NASA Explorer App',
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          foregroundColor: kTransparentColor,
          backgroundColor: kTransparentColor,
          elevation: 0,
          toolbarHeight: getMaxHieghtMediaQuery(context, 0.08),
          shadowColor: kTransparentColor,
          surfaceTintColor: kTransparentColor,
          iconTheme: const IconThemeData(color: kWhiteColor),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: kWhiteColor),
        ),
        listTileTheme: ListTileThemeData(
          contentPadding: const EdgeInsets.symmetric(horizontal: 23),
          tileColor: kGreyColor800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titleTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kWhiteColor,
              ),
        ),
      ),
      routes: {
        NewsScreen.id: (context) => const NewsScreen(),
        SharedPostsScreen.id: (context) => const SharedPostsScreen(),
        ImageGalleryScreen.id: (context) => const ImageGalleryScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        ProfileImageScreen.id: (context) => const ProfileImageScreen(),
        AddScreen.id: (context) => const AddScreen(),
        SolarSystemGalleryScreen.id: (context) =>
            const SolarSystemGalleryScreen(),
        SavedPostsScreen.id: (context) => const SavedPostsScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
