import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/b_auth/presentation/pages/login_screen.dart';
import 'package:msgmee/theme/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Image.asset('assets/bg1.png'),
            Image.asset('assets/bg2.png'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 77),
                  Image.asset(
                    'assets/msgmee_logo.png',
                    height: 116,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'MsgMee',
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'In the future of Community\nNetworks',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            )
          ]),
          Spacer(),
          GestureDetector(
            onTap: () {
              animatedScreenNavigator(context, LoginScreen());
            },
            child: Center(
              child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.lightgrey.withOpacity(0.5),
                            offset: Offset(0, 0.5),
                            blurRadius: 10,
                            spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset('assets/mobile.png'),
                    SizedBox(width: 7),
                    Text('Log In with Mobile Number',
                        style: TextStyle(fontSize: 14))
                  ])),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
