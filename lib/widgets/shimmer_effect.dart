import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect(
      {super.key,
      this.width,
      this.height,
      this.index,
      required this.useMargin});
  final double? width;
  final double? height;
  final int? index;
  final bool useMargin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerEffectColor,
      highlightColor: kGreyColor800,
      child: Container(
        margin: useMargin
            ? EdgeInsets.fromLTRB(
                index != 0 ? 20 : 0,
                0,
                index == 5 ? 20 : 0,
                0,
              )
            : const EdgeInsets.all(0),
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
