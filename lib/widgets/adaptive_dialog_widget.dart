import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';

class AdaptiveDialogWidget extends StatefulWidget {
  const AdaptiveDialogWidget({
    super.key,
    required this.title,
    this.text,
    required this.isAboutMe,
    required this.buttonText,
    this.onTap,
  });

  final String title;
  final String? text;
  final bool isAboutMe;
  final String buttonText;
  final VoidCallback? onTap;

  @override
  State<AdaptiveDialogWidget> createState() => _AdaptiveDialogWidgetState();
}

class _AdaptiveDialogWidgetState extends State<AdaptiveDialogWidget> {
  String developerName = 'Amir M. Zahed';
  String developerEmail = 'mohsenzahed0077@gmail.com';
  String developerPhone = '(+93) 797627651';
  String developerIntro =
      "Hello! I'm Amir M. Zahed, a passionate coder ready to bring ideas to life through the power of technology. With a strong background in coding, I thrive on solving complex problems and developing innovative solutions. Whether it's crafting elegant user interfaces, building robust databases, or creating efficient algorithms, I'm constantly driven to push the boundaries of what's possible. Join me on this exciting journey as we embark on the path of digital transformation and make a positive impact through the world of coding!";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: kScaffoldBackgroundColor,
      backgroundColor: kScaffoldBackgroundColor,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: kWhiteColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      content: widget.isAboutMe
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
              widget.text ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kWhiteColor),
            ),
      actions: [
        TextButton(
          onPressed: widget.onTap ??
              () {
                Navigator.of(context).pop();
              },
          child: Text(
            widget.buttonText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kWhiteColor),
          ),
        ),
      ],
    );
  }
}
