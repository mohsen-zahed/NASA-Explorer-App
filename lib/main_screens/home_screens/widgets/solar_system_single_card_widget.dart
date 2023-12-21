import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';

class SolarSystemSinglCardWidget extends StatelessWidget {
  const SolarSystemSinglCardWidget({
    super.key,
    required this.index,
    required this.solarList,
    required this.onTap,
    required this.planetsList,
  });
  final int index;
  final List<dynamic> solarList;
  final VoidCallback onTap;
  final List planetsList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage(
                //       solarSystemList[index]['planet_image'],
                //     ),
                //   ),
                // ),
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
                    planetsList[index].getPlanetName(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: kWhiteColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    solarList[index].getPlanetSubTitle(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kWhiteColor,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
