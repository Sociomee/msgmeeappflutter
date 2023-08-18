import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget(
      {super.key,
      required this.title,
      required this.color,
      this.fontsize = 14,
      this.textColor = AppColors.white,
      this.borderColor = AppColors.primaryColor,
      required this.ontap,
      this.height});
  final String title;
  final Color color;
  Color? textColor;
  Color? borderColor;
  double? fontsize;
  final VoidCallback ontap;
  double? height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50.w,
        width: 334.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor!)),
        child: Text(title,
            style: TextStyle(
                color: textColor,
                fontSize: fontsize,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
