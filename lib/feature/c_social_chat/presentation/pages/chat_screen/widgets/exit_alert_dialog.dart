import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class ExitAlertDialog extends StatelessWidget {
  const ExitAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 20),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 10),
        Text(
          'You are going to exit group!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Exit',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF368C4E),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: AppColors.grey),
        ),
        Text(
          'Cancel',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF368C4E),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: AppColors.grey),
        ),
        Text(
          'Learn More',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF2F80ED),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
      ]),
    );
  }
}
