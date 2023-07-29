import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../theme/colors.dart';

class BuildPages extends StatelessWidget {
  const BuildPages(
      {super.key,
      required this.imageUrl,
      required this.descriptionText,
      required this.index,
      required this.title});
  final String title;
  final String imageUrl;
  final int index;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 30,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w600,
          ),
          textScaleFactor: 1.0,
        ),
        SizedBox(height: 20),
        SvgPicture.asset(
          imageUrl,
          height: 380.h,
          width: double.infinity,
        ),
        SizedBox(height: 20),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Text(
              descriptionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
              ),
              textScaleFactor: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
