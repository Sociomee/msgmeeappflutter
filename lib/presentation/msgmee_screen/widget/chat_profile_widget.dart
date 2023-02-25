import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

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
                ? Border.all(color: CustomTheme.primaryColor, width: 3)
                : null,
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: CustomTheme.grey,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
          top: 42,
          right: 0,
          child: isOnline
              ? Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomTheme.white, width: 2),
                      color: CustomTheme.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                )
              : Container(),
        )
      ],
    );
  }
}
