import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/e_settings/pages/settings/widgets/logout_dialog.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../blocked_screen/blocked_screen.dart';
import '../../../c_profile/presentation/pages/profile_page.dart';
import '../chat_settings/chat_settings_screen.dart';
import '../delete_account/delete_account_screen.dart';
import '../help_screen/help_screen.dart';
import '../notification_settings/notification_settings.dart';
import '../privacy_settings/privacy_settings_screen.dart';
import '../storage_settings/storage_settings_screen.dart';
import '../sync_invite_screen/sync_invite_screen.dart';

class SettingsOption {
  final String optionName;
  final VoidCallback ontap;
  SettingsOption({
    required this.optionName,
    required this.ontap,
  });
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingsOption> options = [
      SettingsOption(
          optionName: 'Profile Settings',
          ontap: () {
            screenNavigator(context, ProfilePage());
          }),
      SettingsOption(
          optionName: 'Chat Settings',
          ontap: () {
            screenNavigator(context, ChatSettingScreen());
          }),
      SettingsOption(
          optionName: 'Privacy Settings',
          ontap: () {
            screenNavigator(context, PrivacySettingScreen());
          }),
      SettingsOption(
          optionName: 'Notification & Sound Settings',
          ontap: () {
            screenNavigator(context, NotificationSettingsScreen());
          }),
      SettingsOption(
          optionName: 'Storage and Data Settings',
          ontap: () {
            screenNavigator(context, StorageSettingsScreen());
          }),
      SettingsOption(
          optionName: 'Blocked Users',
          ontap: () {
            screenNavigator(context, BlockedPeopleScreen());
          }),
      SettingsOption(
          optionName: 'Syncing and Invite',
          ontap: () {
            screenNavigator(context, SyncInviteScreen());
          }),
      SettingsOption(
          optionName: 'Help & Support',
          ontap: () {
            screenNavigator(context, HelpScreen());
          }),
      SettingsOption(
          optionName: 'Log Out',
          ontap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return LogoutDialog();
                });
            // showModalBottomSheet(
            // context: context,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20)),
            // builder: (context) {
            //   return LogOutBottomSheet();
            // });
          }),
      SettingsOption(
          optionName: 'Delete Account',
          ontap: () {
            screenNavigator(context, DeleterAccountScreen());
          }),
    ];
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
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
          title: Text('Settings',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: AppColors.seconderyColor1,
                onTap: options[index].ontap,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, top: 16, bottom: 16),
                        child: Text(
                          options[index].optionName,
                          style: TextStyle(
                              color: index == options.length - 1
                                  ? Colors.red
                                  : AppColors.grey),
                        ),
                      ),
                      index == options.length - 1
                          ? Container()
                          : Divider(height: 0, color: AppColors.iconColor)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
