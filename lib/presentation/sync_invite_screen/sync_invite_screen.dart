import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../theme/custom_theme.dart';
import 'widget/invite_contact_screen.dart';
import 'widget/share_link_bottomSheet.dart';

class SyncInviteScreen extends StatefulWidget {
  const SyncInviteScreen({super.key});

  @override
  State<SyncInviteScreen> createState() => _SyncInviteScreenState();
}

class _SyncInviteScreenState extends State<SyncInviteScreen> {
  bool readReceipt = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: CustomTheme.black)),
          title: Text(
            'Syncing and Invite',
            style: TextStyle(color: CustomTheme.black),
          )),
      body: Column(
        children: [
          SizedBox(height: 26),
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
                    return ShareLinkBottomSheet(
                      showSociomee: false,
                    );
                  });
            },
            title: Text(
              'Share link',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'Share Msgmee link to your connections\nand Contacts',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                color: CustomTheme.grey, size: 15),
          ),
          Divider(color: CustomTheme.grey),
          ListTile(
            onTap: () {},
            title: Text(
              'Sync to SocioMee',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'You can sync your SocioMee Connections',
              style: TextStyle(fontSize: 12),
            ),
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
          Divider(color: CustomTheme.grey),
          ListTile(
            onTap: () {
              screenNavigator(context, InviteContactScreen());
            },
            title: Text(
              'Invite Contact',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'You can sync your Contact',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                color: CustomTheme.grey, size: 15),
          ),
          Divider(color: CustomTheme.grey),
        ],
      ),
    );
  }
}
