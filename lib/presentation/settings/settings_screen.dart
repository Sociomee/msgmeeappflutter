import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/profile/setup_profile_screen.dart';
import '../../theme/custom_theme.dart';
import '../chat_setting/chat_settings_screen.dart';
import '../privacy_settings/privacy_settings_screen.dart';
import '../profile/profile_settings_screen.dart';

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
      SettingsOption(optionName: 'Notification Settings', ontap: () {}),
      SettingsOption(optionName: 'Storage and Data Settings', ontap: () {}),
      SettingsOption(optionName: 'Blocked Users', ontap: () {}),
      SettingsOption(optionName: 'Syncing and Invite', ontap: () {}),
      SettingsOption(optionName: 'Help & Support', ontap: () {}),
      SettingsOption(optionName: 'Log Out', ontap: () {}),
      SettingsOption(optionName: 'Delete Account', ontap: () {}),
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
