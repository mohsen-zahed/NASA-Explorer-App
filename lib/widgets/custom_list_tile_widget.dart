import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.text,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onListTileTap,
  });
  final String text;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final VoidCallback onListTileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ListTile(
        onTap: onListTileTap,
        trailing: Icon(
          trailingIcon,
          size: 20,
          color: kWhiteColor,
        ),
        leading: Icon(
          leadingIcon,
          color: kWhiteColor,
        ),
        title: Text(text),
      ),
    );
  }
}
