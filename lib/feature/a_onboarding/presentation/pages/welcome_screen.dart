import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/b_auth/presentation/pages/login_screen.dart';
import 'package:msgmee/theme/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/welcome_bg.png'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Image.asset('assets/msgmee_logo.png',
                    height: 128, width: 136.w, fit: BoxFit.cover),
                SizedBox(height: 16.h),
                Text(
                  'MsgMee',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF083A3D),
                    fontSize: 36.27.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(color: AppColors.lightgrey, height: 32, thickness: 1),
                Text(
                  '"Welcome to Msgme, your\nglobal messaging\nplatform!"',
                  style: TextStyle(
                      color: Color(0xFF368C4E),
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 300.w,
                  child: Text(
                    '"Connect, chat, and share with Msgme, uniting the world through messages."',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 15.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
                Spacer(),
                CustomButtonWidget(
                    title: 'Accept terms & Conditions',
                    color: AppColors.darkbtnColor,
                    borderColor: AppColors.darkbtnColor,
                    fontsize: 15.sp,
                    ontap: () {
                      animatedScreenNavigator(context, LoginScreen());
                    }),
                SizedBox(height: 32.h),
                Center(
                  child: Text(
                    'Terms of Services & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF354052),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(children: [
//             Image.asset('assets/bg1.png'),
//             Image.asset('assets/bg2.png'),
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 77),
//                   Image.asset(
//                     'assets/msgmee_logo.png',
//                     height: 116,
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'MsgMee',
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: AppColors.primaryDarkColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'In the future of Community\nNetworks',
//                     style: TextStyle(fontSize: 16),
//                   )
//                 ],
//               ),
//             )
//           ]),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               animatedScreenNavigator(context, LoginScreen());
//             },
//             child: Center(
//               child: Container(
//                   height: 50,
//                   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: AppColors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0x1E000000),
//                           blurRadius: 16,
//                           offset: Offset(0, 0),
//                           spreadRadius: 0,
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Row(mainAxisSize: MainAxisSize.min, children: [
//                     Image.asset('assets/mobile.png'),
//                     SizedBox(width: 7),
//                     Text('Log In with Mobile Number',
//                         style: TextStyle(fontSize: 14))
//                   ])),
//             ),
//           ),
//           SizedBox(height: 100),
//         ],
//       ),
//     );
//   }
// }
