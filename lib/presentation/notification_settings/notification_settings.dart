import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../theme/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
          title: Text(
            'Notification & Sound Settings',
            style: TextStyle(color: AppColors.black),
          )),
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
            title: Text('Chat Notification'),
            subtitle: Text(
              'You will hear the system default sound when a\nmessage is sent or received',
              style: TextStyle(fontSize: 11),
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
                      title: 'Stories Notification',
                    );
                  });
            },
            title: Text('Stories Notification'),
            subtitle: Text(
              'You will hear the system default sound when your\nfriend added their stories',
              style: TextStyle(fontSize: 11),
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
            title: Text('Message Reminders'),
            subtitle: Text(
              'You will hear the system default sound when a\nmessage is sent or received',
              style: TextStyle(fontSize: 11),
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
            title: Text('Mentions'),
            subtitle: Text(
              'You will hear the system default sound when anyone\nmentioned you on story, chats, etc',
              style: TextStyle(fontSize: 11),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            title: Text('Wake Up Notification'),
            trailing: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                activeColor: AppColors.primaryColor,
                value: true,
                onChanged: (w) {}),
          ),
          Divider(color: AppColors.lightgrey, thickness: 1),
          ListTile(
            title: Text('Message preview'),
            subtitle: Text(
                'If turned off, you want send or receive read receipt. read receipts are always sent for\ngroup chats and direct chats '),
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
                    return NotificationBottomSheet(
                      title: 'Group notification',
                    );
                  });
            },
            title: Text('Group notification'),
            subtitle: Text(
                'You will hear the system default sound when a\nmessage is sent or received'),
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
            title: Text('Call notification'),
            subtitle: Text(
                'You will hear the system default sound when a\nmessage is sent or received'),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
        ],
      )),
    );
  }
}
