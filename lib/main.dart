import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/initial_screens/splash_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/news_screen/news_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/profile_screen/sub_screens/shared_posts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAbLIQyIKyAaBViUdokKPCw_u8E3tSFGMI',
      appId: '1:259386221113:android:dcf07517642fb78548a3e8',
      projectId: 'nasa-explorer-app-3be03',
      messagingSenderId: '',
      storageBucket: "myapp.appspot.com",
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
        appBarTheme: const AppBarTheme(
          backgroundColor: kTransparentColor,
          iconTheme: IconThemeData(color: kWhiteColor),
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
      },
      home: const SplashScreen(),
    );
  }
}
