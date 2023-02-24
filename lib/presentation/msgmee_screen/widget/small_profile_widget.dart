import 'package:flutter/material.dart';

import '../../../theme/custom_theme.dart';

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
    print(isMe);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: isMe
                  ? null
                  : Border.all(color: CustomTheme.primaryColor, width: 2)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: CustomTheme.grey,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
          top: 40,
          right: 0,
          child: isOnline
              ? Container(
                  height: 19,
                  width: 19,
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomTheme.white, width: 2),
                      color: CustomTheme.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                )
              : isMe
                  ? Container(
                      height: 19,
                      width: 19,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.add,
                        color: CustomTheme.white,
                        size: 17,
                      ),
                    )
                  : Container(),
        )
      ],
    );
  }
}
