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
                SizedBox(height: 30.h),
                Image.asset('assets/msgmee_logo.png',
                    height: 128.h, width: 136.w, fit: BoxFit.cover),
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
                  '"Welcome to Msgme, your global messaging\nplatform!"',
                  style: TextStyle(
                    color: Color(0xFF368C4E),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '"Connect, chat, and share with Msgme, uniting the world through messages."',
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.32,
                  ),
                ),
                Spacer(),
                CustomButtonWidget(
                    height: 46,
                    title: 'Accept terms & Conditions',
                    color: AppColors.darkbtnColor,
                    borderColor: AppColors.darkbtnColor,
                    fontsize: 18,
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
