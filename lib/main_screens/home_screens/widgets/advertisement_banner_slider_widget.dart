import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class AdvertisementBannerSliderWidget extends StatefulWidget {
  const AdvertisementBannerSliderWidget({
    super.key,
  });

  @override
  State<AdvertisementBannerSliderWidget> createState() =>
      _AdvertisementBannerSliderWidgetState();
}

class _AdvertisementBannerSliderWidgetState
    extends State<AdvertisementBannerSliderWidget> {
  int currentAd = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // image: const DecorationImage(
            //     image: AssetImage(
            //       'assets/images/advertisement_banner.jpeg',
            //     ),
            //     fit: BoxFit.cover),
          ),
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentAd = value;
              });
            },
            itemCount: 3,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 0 : 10,
                  0,
                  0,
                  0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/advertisement_banner.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              3,
              (index) => adSliderIndicator(index: index),
            ),
          ],
        ),
      ],
    );
  }

  AnimatedContainer adSliderIndicator({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: index == currentAd ? 18 : 10,
      height: 3,
      margin: const EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: index == currentAd ? kWhiteColor : kWhiteColor70,
      ),
    );
  }
}
