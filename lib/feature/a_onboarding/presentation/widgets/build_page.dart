import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildPages extends StatelessWidget {
  const BuildPages(
      {super.key,
      required this.imageUrl,
      required this.descriptionText,
      required this.index});
  final String imageUrl;
  final int index;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 40.h),
            index == 1
                ? Text(
                    'Welcome to MsgMee',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textScaleFactor: 1.0,
                  )
                : Container(),
            SizedBox(height: 20),
            Image.asset(
              imageUrl,
              // fit: BoxFit.cover,
              height: 200.h,
              width: double.infinity,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
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
