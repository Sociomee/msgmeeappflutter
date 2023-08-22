import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class SmallProfileWidget extends StatelessWidget {
  const SmallProfileWidget(
      {super.key,
      required this.imageUrl,
      required this.isOnline,
      required this.isMe,
      required this.hasStory});
  final String imageUrl;
  final bool isOnline;
  final bool isMe;
  final bool hasStory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.primaryColor, width: 2)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.grey,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
          top: 40,
          right: 0,
          child: isOnline
              ? Container(
                  height: 13,
                  width: 13,
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
