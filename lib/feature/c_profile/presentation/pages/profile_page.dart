import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import 'package:msgmee/theme/colors.dart';

import '../widgets/broadcasts_widget.dart';
import '../widgets/groups_widget.dart';
import '../widgets/personal_details_widget.dart';
import '../widgets/profile_edit_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserdetailsCubit>().getUserDetailsCubit('917908450663');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leadingWidth: 40,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(Icons.arrow_back_ios,
                      color: AppColors.black, size: 20))),
          titleSpacing: 0,
          title: Text('Profile',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileEditWidget(),
            PersonalDetailsWidget(),
            Column(
              children: [
                BroadCastsWidget(),
                GroupsWidget(),
                SizedBox(height: 30)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
