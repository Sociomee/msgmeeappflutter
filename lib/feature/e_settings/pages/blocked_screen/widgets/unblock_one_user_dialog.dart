import 'package:flutter/material.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';

class UnblockOneUserDialog extends StatelessWidget {
  const UnblockOneUserDialog({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Unblock "$title" ?',
            style: TextStyle(
              color: Colors.black.withOpacity(0.800000011920929),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40),
          CustomButtonWidget(
              title: 'Unblock',
              color: AppColors.primaryColor,
              ontap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Unclocked "$title"'),
                      Text(
                        'Undo',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ));
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
