import 'package:flutter/material.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/theme/colors.dart';

class ClearCacheDialog extends StatelessWidget {
  const ClearCacheDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clear Cache ?',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.800000011920929),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '508.56 MB',
                style: TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          CustomButtonWidget(
              title: 'Confirm',
              color: AppColors.primaryColor,
              ontap: () {
                Navigator.pop(context);
              }),
          SizedBox(height: 20),
          CustomButtonWidget(
              title: 'Cancel',
              color: AppColors.white,
              textColor: AppColors.primaryColor,
              ontap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
