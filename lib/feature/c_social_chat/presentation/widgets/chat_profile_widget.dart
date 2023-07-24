import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class ChatProfileWidget extends StatelessWidget {
  const ChatProfileWidget(
      {super.key,
      required this.imageUrl,
      required this.isOnline,
      required this.hasStory});
  final String imageUrl;
  final bool isOnline;

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
                  : null,
            ),
            child: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(imageUrl))),
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
