import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class TitleWithViewAllButton extends StatelessWidget {
  const TitleWithViewAllButton({
    super.key,
    required this.title,
    required this.onViewAllTap,
  });
  final String title;
  final VoidCallback onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: kWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        GestureDetector(
          onTap: onViewAllTap,
          child: Row(
            children: [
              Text(
                'view all',
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
    );
  }
}
