import 'package:flutter/material.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:msgmee/feature/a_onboarding/presentation/pages/splash_screen.dart';
import 'package:msgmee/helper/local_data.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../../common_widgets/custom_button_widget.dart';
import '../../../../../theme/colors.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure, you want to log out ?',
              style: TextStyle(
                color: Colors.black.withOpacity(0.800000011920929),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),
            CustomButtonWidget(
                height: 50,
                title: 'Log Out',
                color: AppColors.primaryColor,
                ontap: () {
                  Localdata().deleteData('token');
                  SQLiteHelper().clearAndReinitializeDatabase();
                  Navigator.pop(context);
                  animatedScreenReplaceNavigator(context, SplashScreen());
                }),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF81C14B),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
