import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/colors.dart';

class StoriesNotificationBottomSheet extends StatefulWidget {
  const StoriesNotificationBottomSheet({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<StoriesNotificationBottomSheet> createState() =>
      _StoriesNotificationBottomSheetState();
}

class _StoriesNotificationBottomSheetState
    extends State<StoriesNotificationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: Container(
          height: 180.h,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 80,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: AppColors.lightgrey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(widget.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 24),
              InkWell(
                onTap: () {
                  // showModalBottomSheet(
                  //     isScrollControlled: true,
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(25.0),
                  //       ),
                  //     ),
                  //     context: context,
                  //     builder: (context) {
                  //       return NotificationBottomSheet(
                  //         title: 'Chat Notification sound',
                  //       );
                  //     });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, top: 15, bottom: 15),
                  child: Text(
                    'Sociomates Stories',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Divider(color: AppColors.seconderyColor, thickness: 1),
              InkWell(
                onTap: () {
                  // showModalBottomSheet(
                  //     isScrollControlled: true,
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(25.0),
                  //       ),
                  //     ),
                  //     context: context,
                  //     builder: (context) {
                  //       return NotificationBottomSheet(
                  //         title: 'Chat Notification sound',
                  //       );
                  //     });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, top: 15, bottom: 15),
                  child: Text(
                    'MsgMee Friend Stories',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
