import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({super.key});
  static const String id = '/profile_image_screen';

  @override
  State<ProfileImageScreen> createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    String url = map['url'];
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
        ),
      ),
    );
  }
}
