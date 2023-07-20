import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/theme/colors.dart';

class DeleteDialogWidget extends StatelessWidget {
  const DeleteDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You are going to delete 9 selected Groups.All data will be removed!',
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
          CustomButtonWidget(
              title: 'Delete',
              color: AppColors.primaryColor,
              fontsize: 15.sp,
              ontap: () {
                Navigator.pop(context);
              }),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
