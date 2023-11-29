import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/main_screens/add_screen/add_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/home_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/news_screen/news_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/images_screen/images_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/settings_screen/settings_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key,});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  List<Widget> scaffoldScreens = const [
    HomeScreen(),
    NewsScreen(),
    AddScreen(),
    ImagesScreen(),
    SettingsScreen(),
  ];

  int currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          scaffoldScreens[currentScreen],
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kBackgroundColor.withOpacity(0.8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNavItems.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = index;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            bottomNavItems[index]['icon'],
                            size: bottomNavItems[index]['size'],
                            color: currentScreen == index
                                ? kWhiteColor
                                : kWhiteColor30,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 40,
                            ),
                            child: index != 2
                                ? Text(
                                    bottomNavItems[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 10,
                                          color: currentScreen == index
                                              ? kWhiteColor
                                              : kWhiteColor30,
                                        ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
