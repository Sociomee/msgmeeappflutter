import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:msgmee/feature/e_settings/pages/privacy_settings/widget/blocked_contacts_page.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../theme/colors.dart';
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
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 50,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios, color: AppColors.black),
              )),
          title: Text(
            'Privacy Setting',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
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
            title: Text(
              'Last Seen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Everyone',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Profile Photo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Everyone',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Online Status',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'My contacts except',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Group Privacy',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Everyone',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Groups',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Everyone',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
          SizedBox(height: 15),
          ListTile(
            title: Text(
              'Read receipts',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'If turned off, you want send or receive read receipt. read receipts are always sent for\ngroup chats and direct chats ',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
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
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Live Location',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Everyone',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
          ListTile(
            onTap: () {
              animatedScreenNavigator(context, BlockedContactsPage());
            },
            title: Text(
              'Blocked Contacts',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '56 People',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
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
            title: Text(
              'Fingerprint',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'none',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: AppColors.grey),
          ),
          Divider(color: AppColors.lightgrey, height: 0, thickness: 1),
        ],
      )),
    );
  }
}
