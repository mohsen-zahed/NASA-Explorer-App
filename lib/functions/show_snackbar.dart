import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
  required int duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: kWhiteColor,
      duration: Duration(seconds: duration),
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: kWhiteColor),
      ),
    ),
  );
}
