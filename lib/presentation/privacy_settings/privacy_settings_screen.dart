import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../theme/custom_theme.dart';
import 'widget/bottom_sheet_options.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
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
              icon: Icon(Icons.arrow_back_ios, color: CustomTheme.black)),
          title: Text(
            'Privacy Setting',
            style: TextStyle(color: CustomTheme.black),
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
                    return OptionsBottomSheet(
                      title: 'Last Seen',
                      subtitle: 'Who can view me in group',
                    );
                  });
            },
            title: Text('Last Seen'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Profile Photo',
                      subtitle: 'Who can view me in group',
                    );
                  });
            },
            title: Text('Profile Photo'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Online Status',
                      subtitle: 'Who can view me in group',
                    );
                  });
            },
            title: Text('Online Status'),
            subtitle: Text('My contacts except'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Group Privacy',
                      subtitle: 'Who can view me in group',
                    );
                  });
            },
            title: Text('Group Privacy'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Group Privacy',
                      subtitle: 'Who can view me in group',
                    );
                  });
            },
            title: Text('Groups'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          SizedBox(height: 15),
          ListTile(
            title: Text('Read receipts'),
            subtitle: Text(
                'If turned off, you want send or receive read receipt. read receipts are always sent for\ngroup chats and direct chats '),
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
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Live Location',
                      subtitle: 'Who can view my live location',
                    );
                  });
            },
            title: Text('Live Location'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Blocked Contacts',
                      subtitle: '',
                    );
                  });
            },
            title: Text('Blocked Contacts'),
            subtitle: Text('56 People'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
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
                    return OptionsBottomSheet(
                      title: 'Blocked Contacts',
                      subtitle: '',
                    );
                  });
            },
            title: Text('Fingerprint'),
            subtitle: Text('none'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
        ],
      )),
    );
  }
}
