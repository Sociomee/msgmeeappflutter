import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildPages extends StatelessWidget {
  const BuildPages(
      {super.key, required this.imageUrl, required this.descriptionText});
  final String imageUrl;

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 45.h,
            ),
            Image.asset(
              imageUrl,
              // fit: BoxFit.cover,
              height: 270.h,
              width: double.infinity,
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.grey),
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
