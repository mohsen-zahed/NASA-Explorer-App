import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerEffectColor,
      highlightColor: kGreyColor800,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kShimmerEffectColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
