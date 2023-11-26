import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class LoginAccountAndGuestAccountTexts extends StatelessWidget {
  const LoginAccountAndGuestAccountTexts({
    super.key,
    required this.onAlreadyHaveAccountTap,
    required this.onGuestAccountTap,
    required this.text,
  });
  final String text;
  final VoidCallback onAlreadyHaveAccountTap;
  final VoidCallback onGuestAccountTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onAlreadyHaveAccountTap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: kWhiteColor70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: kWhiteColor70,
                  decorationThickness: 2,
                ),
          ),
        ),
        GestureDetector(
          onTap: onGuestAccountTap,
          child: Text(
            'continue as guest',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: kWhiteColor70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: kWhiteColor70,
                  decorationThickness: 2,
                ),
          ),
        )
      ],
    );
  }
}
