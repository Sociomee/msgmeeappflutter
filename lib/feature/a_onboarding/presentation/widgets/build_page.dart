import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
        SizedBox(height: 35.h),
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFF16AF00),
                fontSize: 30,
                fontWeight: FontWeight.w600),
            textScaleFactor: 1.0),
        SizedBox(height: 20.h),
        SvgPicture.asset(
          imageUrl,
          height: MediaQuery.of(context).size.height * .58,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Spacer(),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Text(
              descriptionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textScaleFactor: 1.0,
            ),
          ),
        ),
        SizedBox(height: 16)
      ],
    );
  }
}