import 'package:flutter/material.dart';
import '../../../../common_widgets/cache_image_provider.dart';
import '../../../../theme/colors.dart';

class ChatProfileWidget extends StatelessWidget {
  const ChatProfileWidget(
      {super.key,
      required this.imageUrl,
      required this.isOnline,
      required this.hasStory,
      this.radius});
  final String imageUrl;
  final bool isOnline;
  final double? radius;
  final bool hasStory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: hasStory
                ? Border.all(color: AppColors.primaryColor, width: 3)
                : Border.all(color: AppColors.lightgrey, width: 1),
          ),
          child: SizedBox(
            height: 55,
            width: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CacheImageProvider(
                imageUrl: imageUrl,
                imageId: imageUrl,
                placeholder: Container(),
              ),
            ),
          ),
          // child: CircleAvatar(
          //   radius: radius ?? 28,
          //   backgroundColor: AppColors.grey,
          //   backgroundImage: NetworkImage(imageUrl),
          // ),
        ),
        Positioned(
          top: 40,
          right: 0,
          child: isOnline
              ? Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 2),
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                )
              : Container(),
        )
      ],
    );
  }
}
