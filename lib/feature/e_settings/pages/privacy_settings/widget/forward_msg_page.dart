import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/colors.dart';
import '../../../../c_profile/presentation/pages/media_tab.dart';

class ForwardMsgPage extends StatelessWidget {
  const ForwardMsgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          shadowColor: AppColors.lightgrey1,
          leading: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: AppColors.black, size: 20))),
          leadingWidth: 45,
          titleSpacing: 5,
          title: Text('Forworded media many times',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Media',
                  style: TextStyle(
                    color: Color(0xFF4E4E4E),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Transform.rotate(
                        angle: pi / 2,
                        child: Icon(Icons.tune_outlined,
                            color: AppColors.grey, size: 20)))
              ],
            ),
          ),
          GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(images.length, (index) {
                return Container(
                  height: 103,
                  width: 103,
                  margin: EdgeInsets.all(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
