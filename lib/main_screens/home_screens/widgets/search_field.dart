import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search here...',
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: kWhiteColor70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: kWhiteColor70,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kWhiteColor70,
            ),
          ),
        ),
      ),
    );
  }
}
