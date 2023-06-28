import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';
import '../delete_success_page.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you want to really delete your account ?',
            style: TextStyle(
              color: Colors.black.withOpacity(0.800000011920929),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 40),
          CustomButtonWidget(
              title: 'Delete',
              color: AppColors.primaryColor,
              ontap: () {
                animatedScreenReplaceNavigator(context, DeleteSuccessPage());
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
