import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/common_widgets/shimmer_effect.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import '../../../../theme/colors.dart';
import '../pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

class ProfilePicWidget extends StatefulWidget {
  const ProfilePicWidget({super.key});

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {

  @override
  void initState() {
    // TODO: implement initState
    //context.watch<GetUserdetailsCubit>()
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<GetUserdetailsCubit>().state;
    return Stack(
      children: [
        cubit.status == GetUserDetailsStatus.loading
            ? CustomShimmerEffect(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.grey,
                ),
              )
            :
            // cubit.response.user != null
            //     ? CircleAvatar(
            //         radius: 30,
            //         backgroundColor: AppColors.grey,
            //         backgroundImage:
            //             NetworkImage(cubit.response.user!.otherProfileImage!),
            //       )
            //     :
            (cubit.response.user != null ? CircleAvatar(
                     radius: 30,
                     backgroundColor: AppColors.grey,
                     backgroundImage:
                         NetworkImage(cubit.response.user!.otherProfileImage!),
                   ) : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/profile_icon.png',
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )),
        Positioned(
          top: 40,
          right: 0,
          child: GestureDetector(
            onTap: () {
              // animatedScreenNavigator(context, AudioRecord());
              if (context.read<ShoweditbtnCubit>().state.height == 0) {
                context.read<ShoweditbtnCubit>().showdialog();
              } else {
                context.read<ShoweditbtnCubit>().removeDialog();
              }
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
