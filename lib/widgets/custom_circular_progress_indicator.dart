import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
    this.indicatorColor,
  });
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: indicatorColor ?? kBlackColor,
      strokeWidth: 2,
    );
  }
}
