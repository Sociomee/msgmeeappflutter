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
          titleSpacing: 0,
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
          SizedBox(height: 15),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chat Notification',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when a message is sent or received',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stories Notification',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when your friend added their stories',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Message Reminders',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when a message is sent or received',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mentions',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when anyone mentioned you on story, chats, etc',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          ListTile(
            onTap: () {
              setState(() {
                notification = !notification;
              });
            },
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
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message preview',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      child: Text(
                        'You will get preview of the text message notification at the top of your screen',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 51,
                  child: FlutterSwitch(
                    switchBorder: Border.all(color: AppColors.primaryColor),
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
              ],
            ),
          ),
          SizedBox(height: 5),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Group notification',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when a message is sent or received',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.1), thickness: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
                      title: 'Call notification',
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Call notification',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'You will hear the system default sound when a message is sent or received',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.grey)
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
