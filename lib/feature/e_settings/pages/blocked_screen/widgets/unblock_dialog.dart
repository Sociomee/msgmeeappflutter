import 'package:flutter/material.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';

class UnblockUserDialog extends StatelessWidget {
  const UnblockUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Are you sure, you are going to unblock all contacts !',
          style: TextStyle(
            color: Colors.black.withOpacity(0.800000011920929),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 40),
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
    ));
  }
}
