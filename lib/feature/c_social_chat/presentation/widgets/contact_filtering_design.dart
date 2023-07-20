import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/colors.dart';

class ContactFilteringDesign extends StatelessWidget {
  const ContactFilteringDesign({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    print('text===>$text');
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.darkbtnColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
        Positioned(
          top: 12,
          right: 6,
          child: Transform.rotate(
            angle: .8,
            child: ClipPath(
              clipper: CustomTriangleClipper(),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: AppColors.darkbtnColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
