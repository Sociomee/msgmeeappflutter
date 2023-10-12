import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class ContactFilteringDesign extends StatelessWidget {
  const ContactFilteringDesign({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 46,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    // return Stack(
    // children: [
    //   Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         width: 100,
    //         height: 100,
    //         alignment: Alignment.center,
    //         decoration: BoxDecoration(
    //             color: AppColors.black.withOpacity(.2),
    //             borderRadius: BorderRadius.circular(10)),
    //         child: Text(
    //           text,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 46,
    //             fontFamily: 'Poppins',
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ),
    //       // SizedBox(width: 10)
    //     ],
    //   ),
    // Positioned(
    //   top: 12,
    //   right: 6,
    //   child: Transform.rotate(
    //     angle: .8,
    //     child: ClipPath(
    //       clipper: CustomTriangleClipper(),
    //       child: Container(
    //         width: 8,
    //         height: 8,
    //         decoration: BoxDecoration(color: AppColors.darkbtnColor),
    //       ),
    //     ),
    //   ),
    // )
    //   ],
    // );
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
