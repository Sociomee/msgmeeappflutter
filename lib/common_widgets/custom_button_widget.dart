import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget(
      {super.key,
      required this.title,
      required this.color,
      this.textColor = AppColors.white,
      this.borderColor = AppColors.primaryColor,
      required this.ontap});
  final String title;
  final Color color;
  Color? textColor;
  Color? borderColor;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 334.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor!)),
        child: Text(title,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
