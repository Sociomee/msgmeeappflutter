import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';

import '../../theme/custom_theme.dart';
import 'connect_webpanel_screen.dart';

class LinkedDevicesScreen extends StatelessWidget {
  const LinkedDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomTheme.black,
            )),
        title: Text(
          'Linked Device',
          style: TextStyle(color: CustomTheme.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Image.asset('assets/linked_device.png'),
                  SizedBox(height: 54),
                  Text('Use MsgMee On Your Website',
                      style: TextStyle(fontSize: 23)),
                  SizedBox(height: 28),
                  CustomButtonWidget(
                      title: 'Scan A QR Code',
                      color: CustomTheme.primaryColor,
                      ontap: () {
                        screenNavigator(context, ConncetWenPanelScreen());
                      }),
                  SizedBox(height: 20),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Your personal messages will',
                        style: TextStyle(
                            color: CustomTheme.iconColor, fontSize: 13)),
                    TextSpan(
                        text: ' end to end encrypted',
                        style: TextStyle(
                            color: CustomTheme.primaryColor, fontSize: 13)),
                    TextSpan(
                        text: ' on all',
                        style: TextStyle(
                            color: CustomTheme.iconColor, fontSize: 13)),
                  ])),
                  Text('your devices.',
                      style: TextStyle(
                          color: CustomTheme.iconColor, fontSize: 13)),
                  SizedBox(height: 25),
                ],
              ),
            ),
            Divider(
              height: 0,
              color: CustomTheme.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 5),
                    child: Text('Device Status',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text('Tap a device to log out',
                        style: TextStyle(
                            fontSize: 15, color: CustomTheme.iconColor)),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/chrome.png'),
                      SizedBox(width: 11),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Google Chrome (Mac Os)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Last active today at 07:06 pm',
                              style: TextStyle(
                                  fontSize: 15, color: CustomTheme.iconColor)),
                        ],
                      ),
                      Spacer(),
                      Text('Log out',
                          style: TextStyle(
                              fontSize: 15,
                              color: CustomTheme.errorRedColor,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Divider(
                height: 0,
                color: CustomTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
