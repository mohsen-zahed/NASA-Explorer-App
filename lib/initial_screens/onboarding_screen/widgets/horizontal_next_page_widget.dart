import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/initial_screens/registration_screen/registration_screen.dart';
import 'package:nasa_explorer_app_project/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HorizontalNextPageWidget extends StatefulWidget {
  const HorizontalNextPageWidget({
    super.key,
  });

  @override
  State<HorizontalNextPageWidget> createState() =>
      _HorizontalNextPageWidgetState();
}

class _HorizontalNextPageWidgetState extends State<HorizontalNextPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await SharedPreferencesClass()
                .saveOnboardingStatusToSharedPreferences(isLoggedIn: true);
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                  (route) => false);
            }
          },
          child: const Icon(
            Icons.arrow_circle_right_outlined,
            color: kWhiteColor30,
            size: 40,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Lets get started...',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: kWhiteColor70,
                fontSize: 16,
              ),
        )
      ],
    );
  }
}
