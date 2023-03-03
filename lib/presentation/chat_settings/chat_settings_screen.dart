import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../theme/custom_theme.dart';
import 'widget/chatbackup_bottomsheet.dart';
import 'widget/choose_account_sheet.dart';

class ChatSettingScreen extends StatefulWidget {
  const ChatSettingScreen({super.key});

  @override
  State<ChatSettingScreen> createState() => _ChatSettingScreenState();
}

class _ChatSettingScreenState extends State<ChatSettingScreen> {
  bool backup = false;
  bool videobackup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: CustomTheme.black,
              )),
          title: Text(
            'Chat Settings',
            style: TextStyle(color: CustomTheme.black),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Back up Chat',
                              style: TextStyle(
                                color: CustomTheme.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Last back up:',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('Goole drive ID',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('Date:',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('Size',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                width: 29,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('05:18 pm',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('email@gmail.com',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('02 June 2022',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                  Text('3 GB',
                                      style: TextStyle(
                                          color: CustomTheme.grey,
                                          fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      CupertinoButton(
                          color: CustomTheme.primaryColor,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                          child: Text(
                            'Back up',
                            style: TextStyle(color: CustomTheme.white),
                          ),
                          onPressed: () {})
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                      'Back up your messages and videos to selected google drive\nyou can restore them when you reinstall MsgMee.',
                      softWrap: true,
                      style: TextStyle(color: CustomTheme.grey, fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
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
                      return ChatBackUpBottomSheet();
                    });
              },
              title: Text('Schedule Chat Back up'),
              subtitle: Text('05 June 2022 , 11:09 AM '),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CustomTheme.black,
              ),
            ),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
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
                      return ChooseAccountBottomSheet();
                    });
              },
              title: Text('Choose Google Account'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CustomTheme.black,
              ),
            ),
            Divider(
              color: CustomTheme.lightgrey,
              thickness: 1,
            ),
            ListTile(
              title: Text('Back up using cellular'),
              trailing: SizedBox(
                width: 51,
                child: FlutterSwitch(
                  switchBorder: Border.all(
                    color: CustomTheme.primaryColor,
                    width: 2.0.w,
                  ),
                  activeColor: CustomTheme.primaryColor,
                  inactiveColor: CustomTheme.white,
                  inactiveToggleColor: CustomTheme.primaryColor,
                  width: 51.0.w,
                  height: 26.0.h,
                  toggleSize: 23.0.sp,
                  value: backup,
                  borderRadius: 30.0,
                  padding: 2.0,
                  onToggle: (val) {
                    setState(() {
                      backup = !backup;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text('Include videos in chat back up'),
              trailing: SizedBox(
                width: 51,
                child: FlutterSwitch(
                  switchBorder: Border.all(
                    color: CustomTheme.primaryColor,
                    width: 2.0.w,
                  ),
                  activeColor: CustomTheme.primaryColor,
                  inactiveColor: CustomTheme.white,
                  inactiveToggleColor: CustomTheme.primaryColor,
                  width: 51.0.w,
                  height: 26.0.h,
                  toggleSize: 23.0.sp,
                  value: videobackup,
                  borderRadius: 30.0,
                  padding: 2.0,
                  onToggle: (val) {
                    setState(() {
                      videobackup = !videobackup;
                    });
                  },
                ),
              ),
            ),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
            ListTile(
              title: Text('Export chat'),
              subtitle: Text('Chat will be exported in .abc format'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CustomTheme.black,
              ),
            ),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
            ListTile(
              title: Text('Archive chats'),
              subtitle:
                  Text('All archived chats will be available in archived list'),
            ),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
            ListTile(
                title: Text('Clear chats'),
                subtitle: Text(
                    'All chat will be cleared. It can be recovered later if you have backup')),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
            ListTile(
              title: Text('Delete all chats'),
              subtitle: Text('You can delete all chats anytime at once'),
            ),
            Divider(color: CustomTheme.lightgrey, thickness: 1),
            ListTile(
              title: Text('Choose Language'),
              subtitle: Text('English'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: CustomTheme.black,
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
