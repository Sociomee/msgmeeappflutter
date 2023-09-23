// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:msgmee/common_widgets/cache_image_provider.dart';
// import 'package:msgmee/common_widgets/shimmer_effect.dart';
// import 'package:msgmee/feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
// import 'package:msgmee/helper/navigator_function.dart';

// import '../../../../theme/colors.dart';
// import '../pages/profile_scan_page.dart';
// import 'edit_profile_pic_widget.dart';

// class ProfileEditWidget extends StatelessWidget {
//   const ProfileEditWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var cubit = context.watch<GetUserdetailsCubit>().state;
//     if (cubit.status == GetUserDetailsStatus.loaded) {
//       return Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                     height: 125.w,
//                     width: 125.w,
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: AppColors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.lightgrey,
//                           offset: Offset(0, 0.5),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: cubit.response.data!.profilePic == null
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(100),
//                             child: Image.asset('assets/profile_icon.png'),
//                           )
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(100),
//                             child: CacheImageProvider(
//                               imageUrl: cubit.response.data!.profilePic!,
//                               imageId: cubit.response.data!.profilePic!,
//                               height: 120.w,
//                               width: 120.w,
//                               placeholder: Container(),
//                             ),
//                           )
//                     // : CircleAvatar(
//                     //     radius: 50,
//                     //     backgroundColor: AppColors.grey,
//                     //     backgroundImage:
//                     //         NetworkImage(cubit.response.data!.profilePic!),
//                     //   ),
//                     )
//               ],
//             ),
//             SizedBox(width: 20),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (cubit.response.data != null)
//                   Text(cubit.response.data!.firstName ?? "Name Not Provided",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
//                 SizedBox(height: 10),
//                 Text('@shreya_singh012',
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black54)),
//                 SizedBox(height: 10),
//                 GestureDetector(
//                     onTap: () {
//                       animatedScreenNavigator(context, ProfileScanPage());
//                     },
//                     child: Icon(Icons.qr_code, color: AppColors.primaryColor))
//               ],
//             ),
//             Spacer(),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     animatedScreenNavigator(context, EditProfilePicWidget());
//                   },
//                   child: Text('Edit',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: 'DM Sans',
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.primaryColor)),
//                 ),
//                 SizedBox(height: 66)
//               ],
//             ),
//           ],
//         ),
//       );
//     }
//     return CustomShimmerEffect(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           children: [
//             Container(
//               height: 120.w,
//               width: 120.w,
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: AppColors.white,
//               ),
//             ),
//             SizedBox(width: 24),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 20,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: AppColors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 15,
//                   width: 130,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: AppColors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 24,
//                   width: 24,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
