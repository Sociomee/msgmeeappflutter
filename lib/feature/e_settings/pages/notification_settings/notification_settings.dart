import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../theme/colors.dart';
import 'widgets/notification_bottom_sheet.dart';
import 'widgets/stories_notification_widget.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool readReceipt = false;
  bool notification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          shadowColor: AppColors.lightgrey1,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20,
                )),
          ),
          leadingWidth: 45,
          titleSpacing: 5,
          title: Text('Notification & Sound Settings',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return NotificationBottomSheet(
                      title: 'Chat Notification Sound',
                    );
                  });
            },
            title: Text(
              'Chat Notification',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when a message is sent or received',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return StoriesNotificationBottomSheet(
                        title: 'Stories Notification');
                  });
            },
            title: Text(
              'Stories Notification',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when your friend added their stories',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return NotificationBottomSheet(
                      title: 'Message Reminders sound',
                    );
                  });
            },
            title: Text(
              'Message Reminders',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when a message is sent or received',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return NotificationBottomSheet(
                        title: 'Message Reminders sound');
                  });
            },
            title: Text(
              'Mentions',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when anyone mentioned you on story, chats, etc',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            title: Text(
              'Wake Up Notification',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                activeColor: AppColors.primaryColor,
                value: notification,
                onChanged: (w) {
                  setState(() {
                    notification = !notification;
                  });
                }),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            title: Text(
              'Message preview',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'If turned off, you want send or receive read receipt. read receipts are always sent for group chats and direct chats ',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: SizedBox(
              width: 51,
              child: FlutterSwitch(
                switchBorder: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.0.w,
                ),
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.white,
                inactiveToggleColor: AppColors.primaryColor,
                width: 51.0.w,
                height: 26.0.h,
                toggleSize: 23.0.sp,
                value: readReceipt,
                borderRadius: 30.0,
                padding: 2.0,
                onToggle: (val) {
                  setState(() {
                    readReceipt = !readReceipt;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return NotificationBottomSheet(title: 'Group notification');
                  });
            },
            title: Text(
              'Group notification',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when a message is sent or received',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return NotificationBottomSheet(title: 'Call notification');
                  });
            },
            title: Text(
              'Call notification',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'You will hear the system default sound when a message is sent or received',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
        ],
      )),
    );
  }
}
