import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomPostTextField extends StatelessWidget {
  const CustomPostTextField({
    super.key,
    required TextEditingController postTextEditingController,
    required this.hintText,
  }) : _controller = postTextEditingController;

  final TextEditingController _controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: kWhiteColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: kWhiteColor30),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: kWhiteColor70),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
      ),
      maxLines: hintText.contains('title') ? 1 : null,
    );
  }
}
