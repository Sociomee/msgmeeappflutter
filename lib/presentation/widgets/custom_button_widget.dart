import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/custom_theme.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 334.w,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(title,
          style: const TextStyle(
              color: CustomTheme.white,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
    );
  }
}
