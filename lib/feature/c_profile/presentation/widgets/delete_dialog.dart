import 'package:flutter/material.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
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
              'You are going to delete 9 selected\nGroups.\nAll data will be removed!'),
          SizedBox(height: 20),
          CustomButtonWidget(
              title: 'Delete',
              color: AppColors.primaryColor,
              ontap: () {
                Navigator.pop(context);
              }),
          SizedBox(height: 10),
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
