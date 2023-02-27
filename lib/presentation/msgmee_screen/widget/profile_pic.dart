import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: CustomTheme.grey,
          backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
        ),
        Positioned(
          top: 40,
          right: 0,
          child: Container(
            height: 19,
            width: 19,
            decoration: BoxDecoration(
                border: Border.all(color: CustomTheme.white, width: 2),
                color: CustomTheme.darkgreen,
                borderRadius: BorderRadius.circular(100)),
          ),
        )
      ],
    );
  }
}
