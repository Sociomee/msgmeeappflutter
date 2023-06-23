import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

import '../widgets/broadcasts_widget.dart';
import '../widgets/groups_widget.dart';
import '../widgets/personal_details_widget.dart';
import '../widgets/profile_edit_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
        title: Text(
          'Profile',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileEditWidget(),
            PersonalDetailsWidget(),
            BroadCastsWidget(),
            GroupsWidget(),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
