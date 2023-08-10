import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class MediaPreviewWidget extends StatelessWidget {
  const MediaPreviewWidget(
      {super.key, required this.size, required this.time, required this.image});
  final String size;
  final String time;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5),
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(image, fit: BoxFit.cover)),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              size,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 8,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 8,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
