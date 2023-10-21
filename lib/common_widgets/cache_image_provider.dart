import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static final CacheManager cacheManager = CacheManager(Config(
    'cacheKey',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));
}

class CacheImageProvider extends StatelessWidget {
  const CacheImageProvider(
      {super.key,
      required this.imageUrl,
      required this.imageId,
      this.height,
      this.width,
      required this.placeholder,
      this.errorWidget});
  final String imageUrl;
  final String imageId;
  final double? height;
  final double? width;
  final Widget placeholder;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager.cacheManager,
      key: Key(imageId),
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return placeholder;
      },
      errorWidget: (context, url, error) {
        log('image loading error $error');
        return errorWidget ??
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  color: AppColors.lightgrey),
              child: const Icon(
                Icons.error_outline,
                color: AppColors.errorRedColor,
              ),
            );
      },
    );
  }
}
