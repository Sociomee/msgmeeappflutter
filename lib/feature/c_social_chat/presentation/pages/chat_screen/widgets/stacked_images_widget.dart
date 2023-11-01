import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../common_widgets/cache_image_provider.dart';

class StackedImageWidget extends StatelessWidget {
  const StackedImageWidget({super.key, required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 22.0 * images.length,
        height: 35,
        child: Center(
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < images.length; i++)
                if (images.isNotEmpty)
                  Positioned(
                    left: 24 - (i * 5),
                    top: 0,
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: images[i],
                          fit: BoxFit.cover,
                          cacheManager: CustomCacheManager.cacheManager,
                          key: Key(images[i]),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
