import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';

class NoConnectionScreen extends StatefulWidget {
  static const String id = '/no_connection_screen';

  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: Image(
                image: const AssetImage(
                    'assets/images/no_connection_wallpaper.jpeg'),
                fit: BoxFit.cover,
                width: getMaxWidthMediaQuery(context),
                height: getMaxHieghtMediaQuery(context),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ooops!\nConnection problem!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w900,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/no_connection_wallpaper.jpeg'),
                    maxRadius: 170,
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () async {
                      await checkInternetConnectivity(context);
                    },
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 35,
                      color: kWhiteColor,
                    ),
                  ),
                  Text(
                    'retry!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: kWhiteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
