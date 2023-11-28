import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class SolarSystemSinglCardWidget extends StatelessWidget {
  const SolarSystemSinglCardWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        index != 0 ? 20 : 0,
        0,
        index == 5 ? 20 : 0,
        0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kGreyColor800,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/earth.png'),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earth',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: kWhiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'The Green Planet',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
