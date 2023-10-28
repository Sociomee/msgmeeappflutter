import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_profile/presentation/widgets/choose_gender_bottomsheet.dart';
import 'package:msgmee/helper/context_ext.dart';

import '../../../../common_widgets/shimmer_effect.dart';
import '../../../../data/api_data_source/repository/sociomee/sync_socimee_repository.dart';
import '../../../c_social_chat/presentation/cubit/sync_sociomee/sync_sociomee_cubit.dart';
import 'choose_date_of_birth.dart';
import 'choose_interest_bottomsheet.dart';
import '../../../../theme/colors.dart';
import 'custom_interests_gridview.dart';
import 'edit_bio_bottomsheet.dart';

class PersonalDetailsWidget extends StatefulWidget {
  const PersonalDetailsWidget({
    super.key,
  });
  // final List<String> ids;
  @override
  State<PersonalDetailsWidget> createState() => _PersonalDetailsWidgetState();
}

class _PersonalDetailsWidgetState extends State<PersonalDetailsWidget> {
  late SyncSociomeeCubit _cubit;
  @override
  void initState() {
    // context.read<InterestCubit>().getInterests();
    // context.read<InterestCubit>().getfilterdData(widget.ids);
    _cubit = context.read<SyncSociomeeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.description_outlined),
              SizedBox(width: 5),
              Text('Bio',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return EditBioBottomSheet();
                      });
                },
                child: Text('Edit',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor)),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'not set',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Mobile Number',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(
                  'not set',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SvgPicture.asset('assets/account_circle.svg'),
              SizedBox(width: 5),
              Text('Gender',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return ChooseGenderBottomSheet();
                      });
                },
                child: Text('Edit',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor)),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(
                  'not set',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SvgPicture.asset('assets/event.svg'),
              SizedBox(width: 5),
              Text('Date Of Birth',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return ChooseDateOfBirthBottomSheet();
                      });
                },
                child: Text('Edit',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor)),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(
                  'not set',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SvgPicture.asset('assets/heart_plus.svg'),
              SizedBox(width: 5),
              Text('Interests',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return ChooseInterestBottomSheet();
                      });
                },
                child: Text('Edit',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor)),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30),
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //         color: AppColors.grey.withOpacity(.1),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: GridView.builder(
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           crossAxisSpacing: 0.0,
        //           mainAxisSpacing: 8.0,
        //           mainAxisExtent: 40),
        //       padding: EdgeInsets.all(0),
        //       physics: NeverScrollableScrollPhysics(),
        //       shrinkWrap: true,
        //       itemCount: interest.intersts.length,
        //       itemBuilder: (context, index) {
        //         double textWidth = interest.intersts[index].name!.length * 17;
        //         return GestureDetector(
        //           onTap: () {},
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
        //                           color: AppColors.primaryColor,
        //                           borderRadius: BorderRadius.circular(10)),
        //                       child: Text(
        //                         interest.intersts[index].name!,
        //                         overflow: TextOverflow.ellipsis,
        //                         style: TextStyle(
        //                           color: AppColors.white,
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
        // ))
        Center(
          child: Container(
              width: context.screenWidth - 40,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomInterestGridview()),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //         color: AppColors.grey.withOpacity(.1),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             Container(
        //               padding:
        //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(5),
        //                   color: AppColors.primaryColor),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Text("Gardening",
        //                       style: TextStyle(
        //                         color: AppColors.white,
        //                         fontSize: 15.sp,
        //                         fontFamily: 'DM Sans',
        //                         fontWeight: FontWeight.w700,
        //                       )),
        //                   Icon(Icons.close, color: AppColors.white)
        //                 ],
        //               ),
        //             ),
        //             SizedBox(width: 10),
        //             Container(
        //               padding:
        //                   EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(5),
        //                   color: AppColors.primaryColor),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'Photography',
        //                     style: TextStyle(
        //                       color: AppColors.white,
        //                       fontSize: 15.sp,
        //                       fontFamily: 'DM Sans',
        //                       fontWeight: FontWeight.w700,
        //                     ),
        //                   ),
        //                   Icon(Icons.close, color: AppColors.white)
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //         SizedBox(height: 10),
        //         Container(
        //           width: 102,
        //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               color: AppColors.primaryColor),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text('Playing',
        //                   style: TextStyle(
        //                     color: AppColors.white,
        //                     fontSize: 15.sp,
        //                     fontFamily: 'DM Sans',
        //                     fontWeight: FontWeight.w700,
        //                   )),
        //               Icon(Icons.close, color: AppColors.white)
        //             ],
        //           ),
        //         )
        //       ],
        //     ),

        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: AppColors.grey.withOpacity(.4),
            height: 0,
            thickness: 6,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset('assets/icon.svg')),

        _cubit.state.checkStatus == CheckSociomeeStatus.loading
            ? CustomShimmerEffect(
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.grey,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.grey,
                  backgroundImage: NetworkImage(
                    _cubit
                        .state.syncResponse.data!.successResult!.profileImage!,
                  ),
                ),
              ),
        SizedBox(height: 10),
        _cubit.state.checkStatus == CheckSociomeeStatus.loading
            ? CustomShimmerEffect(
                child: Container(
                height: 10,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.grey),
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    _cubit.state.syncResponse.data!.successResult!.userName ??
                        '',
                    style: TextStyle(fontSize: 14, color: AppColors.black)),
              ),
        SizedBox(height: 12),
        _cubit.state.checkStatus == CheckSociomeeStatus.loading
            ? CustomShimmerEffect(
                child: Container(
                height: 10,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.grey),
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("+${_cubit.state.phone}",
                    style: TextStyle(fontSize: 14, color: AppColors.black)),
              ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Total SocioMates:',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black),
                ),
                TextSpan(
                    text: '232',
                    style: TextStyle(fontSize: 14, color: AppColors.black))
              ])),
              InkWell(
                onTap: () {
                  SyncSocimeeService().removeSocimee();
                },
                child: Text('Unlink',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
