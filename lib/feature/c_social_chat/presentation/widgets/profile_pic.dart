import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.grey,
            backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600')),
        Positioned(
          top: 40,
          right: 0,
          child: GestureDetector(
            onTap: () {
              // context.read<ShoweditbtnCubit>().showdialog();
            },
            child: Container(
              height: 19,
              width: 19,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.add,
                color: AppColors.white,
                size: 17,
              ),
            ),
          ),
        )
      ],
    );
  }
}
