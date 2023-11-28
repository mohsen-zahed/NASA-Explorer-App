import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class AppLogoAndProfileImage extends StatelessWidget {
  const AppLogoAndProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/nasa_text_logo.png', scale: 50),
        // Text(
        //   'NASA',
        //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //         color: kRedColor,
        //         fontSize: 30,
        //         fontWeight: FontWeight.w900,
        //       ),
        // ),
        Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile_pic.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
