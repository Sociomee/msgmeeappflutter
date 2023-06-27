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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text(
            'Forworded media many times',
            style: TextStyle(color: AppColors.black),
          )),
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
                Icon(Icons.tune_outlined, color: AppColors.grey)
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
