import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../theme/custom_theme.dart';

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
            title: Text('Last Seen'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          ListTile(
            title: Text('Profile Photo'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          ListTile(
            title: Text('Online Status'),
            subtitle: Text('My contacts except'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          ListTile(
            title: Text('Group Privacy'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          ListTile(
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
            title: Text('Live Location'),
            subtitle: Text('Everyone'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
          ListTile(
            title: Text('Blocked Contacts'),
            subtitle: Text('56 People'),
            trailing: Icon(Icons.arrow_forward_ios, color: CustomTheme.grey),
          ),
          Divider(color: CustomTheme.lightgrey, height: 0, thickness: 1),
        ],
      )),
    );
  }
}
