import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/authentication/login_screen.dart';
import 'package:msgmee/presentation/msgmee_screen/msgmee_screen.dart';
import 'package:msgmee/presentation/onboarding/widgets/account_dialog.dart';
import 'package:msgmee/theme/custom_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Image.asset('assets/bg1.png'),
              Image.asset('assets/bg2.png'),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 37),
                    Image.asset(
                      'assets/msgmee_logo.png',
                      height: 116,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'MsgMee',
                      style: TextStyle(
                          fontSize: 30,
                          color: CustomTheme.msgmeeTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'In the future of\nCommunity Networks',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              )
            ]),
            SizedBox(height: 80),
            InkWell(
              onTap: () {
                animatedScreenNavigator(context, MsgmeeScreen());
                // animatedScreenNavigator(context, LoginScreen());
              },
              child: Center(
                child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CustomTheme.white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomTheme.lightgrey.withOpacity(0.5),
                          offset: Offset(0, 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(color: CustomTheme.grey),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Image.asset('assets/mobile.png'),
                      SizedBox(width: 7),
                      Text('Continue with Mobile Number',
                          style: TextStyle(fontSize: 14))
                    ])),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AccountDialogWidget();
                    });
              },
              child: Center(
                child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CustomTheme.white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomTheme.lightgrey.withOpacity(0.5),
                          offset: Offset(0, 0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(color: CustomTheme.grey),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Image.asset('assets/sociomee.png'),
                      SizedBox(width: 7),
                      Text('Continue with SocioMee',
                          style: TextStyle(fontSize: 14))
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
