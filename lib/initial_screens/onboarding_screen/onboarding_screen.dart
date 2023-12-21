import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/initial_screens/onboarding_screen/widgets/horizontal_next_page_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg0.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                SizedBox(
                  width: 130,
                  height: 130,
                  child: Hero(
                    tag: 'NASA Logo',
                    child: Image.asset(
                      'assets/images/nasa_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Explore Things Beyond The Galaxy!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: kWhiteColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 15),
                const HorizontalNextPageWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
