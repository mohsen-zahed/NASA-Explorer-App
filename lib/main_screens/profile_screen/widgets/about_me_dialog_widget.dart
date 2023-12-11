import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';

class AboutMeDialogWidget extends StatelessWidget {
  const AboutMeDialogWidget({
    super.key,
    required this.title,
    this.text,
    required this.isAboutMe,
    required this.buttonText,
  });

  final String title;
  final text;
  final bool isAboutMe;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: kWhiteColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      content: isAboutMe
          ? Text.rich(
              TextSpan(
                text: '$developerIntro\n\n',
                children: [
                  TextSpan(
                    text: 'Developed by: $developerName\n',
                    children: [
                      TextSpan(
                        text: 'Email: $developerEmail\n',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => mail(email: developerEmail),
                        children: [
                          TextSpan(
                            text: 'Phone: $developerPhone',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => call(phoneNumber: developerPhone),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kWhiteColor),
            )
          : Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kWhiteColor),
            ),
      actions: [
        TextButton(
          child: Text(
            buttonText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kWhiteColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
