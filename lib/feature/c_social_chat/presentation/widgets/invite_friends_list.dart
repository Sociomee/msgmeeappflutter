import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/newmodels/contact_model.dart';

import '../../../../common_widgets/shimmer_effect.dart';
import '../../../../data/model/phonebook_model.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_contact/get_contact_cubit.dart';

class InviteFriendsList extends StatelessWidget {
   InviteFriendsList({super.key, required this.contacts, this.msgMeeUsers});
  final List<PhoneBookUserModel> contacts;
  final List<String>? msgMeeUsers;
  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ContactCubit>().state;

    return Column(
      children: [
        cubit.isLoading
            ? CustomShimmerEffect()
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.toSet().toList().length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return msgMeeUsers!.contains(contacts[index].phone) ? Container() : Padding(
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
                            contacts[index].name[0],
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 12),
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${contacts[index].name}",
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "${contacts[index].phone}",
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
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
      ],
    );
  }
}
