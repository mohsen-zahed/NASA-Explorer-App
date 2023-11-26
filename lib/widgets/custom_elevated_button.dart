import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.textButton,
    required this.onPressed,
  });
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          textButton,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 22,
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
