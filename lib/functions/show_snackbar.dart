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
      content: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(
            Icons.check,
            size: 20,
            color: kWhiteColor,
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    ),
  );
}
