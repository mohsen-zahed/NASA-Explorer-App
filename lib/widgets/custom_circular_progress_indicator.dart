import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: kBlackColor,
      strokeWidth: 2,
    );
  }
}
