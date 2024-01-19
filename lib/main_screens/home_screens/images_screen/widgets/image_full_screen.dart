import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: image,
            cacheManager: CacheManager(
              Config(
                'cacheKey',
                stalePeriod: const Duration(hours: 1),
              ),
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
