import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common_widgets/shimmer_effect.dart';
import '../../../../helper/get_contacts.dart';
import '../../../../theme/colors.dart';

class InviteFriendsList extends StatelessWidget {
  const InviteFriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ContactCubit>().state;
    print('contacts--->${cubit.contacts.length}');

    return Column(
      children: [
        cubit.isLoading
            ? CustomShimmerEffect()
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: cubit.contacts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? AppColors.darkgreen
                                  : AppColors.blue,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            cubit.contacts[index].displayName[0],
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 12),
                        SizedBox(
                          width: 200,
                          child: Text(
                            cubit.contacts[index].displayName,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/invite.svg',
                                  height: 16.h),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Invite',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
        // : Text("No Contacts Found")
      ],
    );
  }
}
