import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/update_profile/update_profile_cubit.dart';
import '../../../../helper/local_data.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_user_details/get_userdetails_cubit.dart';

class ChooseInterestBottomSheet extends StatefulWidget {
  const ChooseInterestBottomSheet({super.key});

  @override
  State<ChooseInterestBottomSheet> createState() =>
      _ChooseInterestBottomSheetState();
}

class _ChooseInterestBottomSheetState extends State<ChooseInterestBottomSheet> {
  List<String> selectedInterests = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 80,
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: AppColors.lightgrey,
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(height: 12.w),
          Text('Choose your Interests',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 14.w),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Please select ',
                style: TextStyle(
                    color: Color(0xB2333333),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'at least 3 interests',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor.withOpacity(.8))),
            TextSpan(
                text: ' for a better',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xB2333333)))
          ])),
          Text('in-app experience',
              style: TextStyle(fontSize: 14, color: Color(0xB2333333))),
          SizedBox(height: 20.w),
          // if (cubit.response.data != null)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30),
          //   child: SizedBox(
          //     height: 200.h,
          //     child: GridView.builder(
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3,
          //           crossAxisSpacing: 0.0,
          //           mainAxisSpacing: 8.0,
          //           mainAxisExtent: 40),
          //       padding: EdgeInsets.all(0),
          //       shrinkWrap: true,
          //       itemCount: cubit.response.data!.length,
          //       itemBuilder: (context, index) {
          //         double textWidth =
          //             cubit.response.data![index].name!.length * 17;
          //         return GestureDetector(
          //           onTap: () {
          //             if (selectedInterests
          //                 .contains(cubit.response.data![index].sId)) {
          //               setState(() {
          //                 selectedInterests
          //                     .remove(cubit.response.data![index].sId);
          //               });
          //             } else {
          //               setState(() {
          //                 selectedInterests
          //                     .add(cubit.response.data![index].sId!);
          //               });
          //             }
          //             log('interests------>$selectedInterests');
          //           },
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               SizedBox(
          //                 height: 36,
          //                 width: textWidth,
          //                 child: Center(
          //                   child: Container(
          //                       margin: EdgeInsets.only(left: 10),
          //                       height: 36,
          //                       width: textWidth,
          //                       alignment: Alignment.center,
          //                       decoration: BoxDecoration(
          //                           color: selectedInterests.contains(
          //                                   cubit.response.data![index].sId)
          //                               ? AppColors.primaryColor
          //                               : AppColors.lightgrey1,
          //                           borderRadius: BorderRadius.circular(10)),
          //                       child: Text(
          //                         cubit.response.data![index].name!,
          //                         overflow: TextOverflow.ellipsis,
          //                         style: TextStyle(
          //                           color: selectedInterests.contains(
          //                                   cubit.response.data![index].sId)
          //                               ? AppColors.white
          //                               : Color(0xFF4E4E4E),
          //                           fontSize: 16,
          //                           fontFamily: 'Roboto',
          //                           fontWeight: FontWeight.w400,
          //                         ),
          //                       )),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonWidget(
                height: 40.w,
                title: 'Save',
                borderColor: Colors.transparent,
                color: selectedInterests.length < 3
                    ? AppColors.primaryColor.withOpacity(.6)
                    : AppColors.primaryColor,
                ontap: () async {
                  // context
                  //     .read<UpdateProfileCubit>()
                  //     .updateInterest(selectedInterests);
                  var phone = await Localdata().readData('phone');
                  context
                      .read<GetUserdetailsCubit>()
                      .getUserDetailsCubit();
                  // context.read<InterestCubit>().getInterests();
                  // context
                  //     .read<InterestCubit>()
                  //     .getfilterdData(selectedInterests);
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
