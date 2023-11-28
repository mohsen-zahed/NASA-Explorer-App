import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class HorizontalAstronautFiguresSlider extends StatelessWidget {
  const HorizontalAstronautFiguresSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Astronaut figures',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kWhiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    'All',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: kWhiteColor,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kWhiteColor,
                    size: 12,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                10,
                (index) => Padding(
                  padding: EdgeInsets.only(right: index == 10 ? 0 : 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: kWhiteColor70),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/armstrong.jpeg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 85,
                        ),
                        child: Text(
                          'Neil Gourgin Armstrong',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
