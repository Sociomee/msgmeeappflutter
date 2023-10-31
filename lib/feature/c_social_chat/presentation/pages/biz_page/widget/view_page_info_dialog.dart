import 'package:flutter/material.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/theme/colors.dart';

class ViewPageInfoDialog extends StatelessWidget {
  const ViewPageInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'To view more info. about this BizPage, please visit SocioMee App.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: CustomButtonWidget(
                height: 40,
                title: 'Open Sociomee',
                color: AppColors.primaryColor,
                ontap: () {
                  Navigator.pop(context);
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF81C14B),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
