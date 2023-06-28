import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class ExportChatDialog extends StatelessWidget {
  const ExportChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 30),
        Text(
          'Export all chats !',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Without media',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF368C4E),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            color: AppColors.primaryColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Include media',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF368C4E),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 30),
      ]),
    );
  }
}
