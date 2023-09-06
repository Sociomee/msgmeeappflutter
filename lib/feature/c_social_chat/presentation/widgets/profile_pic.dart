import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import '../../../../theme/colors.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<GetUserdetailsCubit>().state;
    return Stack(
      children: [
        if (cubit.response.data != null)
          cubit.response.data!.profilePic == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/profile_icon.png',
                      height: 30, fit: BoxFit.cover))
              : CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.grey,
                  backgroundImage:
                      NetworkImage(cubit.response.data!.profilePic!)),
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
