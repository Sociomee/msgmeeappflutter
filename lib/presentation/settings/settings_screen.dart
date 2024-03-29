import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/profile/setup_profile_screen.dart';
import '../../theme/custom_theme.dart';
import '../blocked_screen/blocked_screen.dart';
import '../chat_settings/chat_settings_screen.dart';
import '../delete_account/delete_account_screen.dart';
import '../help_screen/help_screen.dart';
import '../notification_settings/notification_settings.dart';
import '../privacy_settings/privacy_settings_screen.dart';
import '../profile/profile_settings_screen.dart';
import '../storage_settings/storage_settings_screen.dart';
import '../sync_invite_screen/sync_invite_screen.dart';
import 'widgets/logout_bottomsheet.dart';

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
            screenNavigator(context, ProfileSettingScreen());
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
          optionName: 'Notification Settings',
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
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                builder: (context) {
                  return LogOutBottomSheet();
                });
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomTheme.black,
            )),
        title: Text(
          'Settings',
          style: TextStyle(color: CustomTheme.black),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: CustomTheme.seconderyColor1,
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
                                  : CustomTheme.grey),
                        ),
                      ),
                      index == options.length - 1
                          ? Container()
                          : Divider(height: 0, color: CustomTheme.iconColor)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
