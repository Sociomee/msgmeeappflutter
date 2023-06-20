import 'package:flutter/material.dart';

import '../../../../../../theme/colors.dart';

class DeleteBroadCastDialog extends StatelessWidget {
  const DeleteBroadCastDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('You are  going to delete broadcast!',
            style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 27),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Text('Delete', style: TextStyle(color: AppColors.primaryColor)),
        ),
        Divider(color: AppColors.grey, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Text('Cancel', style: TextStyle(color: AppColors.primaryColor)),
        ),
        Divider(color: AppColors.grey, height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('Learn More', style: TextStyle(color: AppColors.blue)),
        ),
      ]),
    );
  }
}
