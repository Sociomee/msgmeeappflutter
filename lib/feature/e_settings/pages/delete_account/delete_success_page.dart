import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteSuccessPage extends StatelessWidget {
  const DeleteSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Spacer(),
            Image.asset('assets/sad.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Sad To See You Go',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'Gorem ipsum dolor sit amet, consectetur adipiscing elit. Gorem ipsum dolor sit amet, consectetur adipiscing elit.. Gorem ipsum dolor sit amet, consectetur adipiscing elit.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
          ]),
          Image.asset('assets/delete_ac1.png'),
          Positioned(top: 230.h, child: Image.asset('assets/delete_ac2.png')),
          Positioned(
              bottom: 180.h, child: Image.asset('assets/delete_ac3.png')),
          Positioned(
              bottom: 122,
              right: 0,
              child: Image.asset('assets/delete_ac4.png')),
        ],
      )),
    );
  }
}
