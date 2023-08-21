import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';

import '../../../../theme/colors.dart';
import 'connect_webpanel_screen.dart';

class LinkedDevicesScreen extends StatelessWidget {
  const LinkedDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          leadingWidth: 40,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios,
                    color: AppColors.black, size: 18),
              )),
          titleSpacing: 5,
          title: Text(
            'Linked Device',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(child: Image.asset('assets/linked_device.png')),
                  SizedBox(height: 54),
                  Center(
                      child: Text(
                    'Use MsgMee On Your Website',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  SizedBox(height: 28),
                  CustomButtonWidget(
                      height: 50,
                      title: 'Scan A QR Code',
                      color: AppColors.primaryColor,
                      ontap: () {
                        screenNavigator(context, ConncetWenPanelScreen());
                      }),
                  SizedBox(height: 20),
                  Text(
                    'Your personal messages will end to end encrypted on all your devices.',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 5, left: 20, right: 20),
                    child: Text(
                      'Linked Devices',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(height: 10),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.lightgrey,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/chrome.png',
                        height: 46,
                      ),
                      SizedBox(width: 11),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Google Chrome',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' (Mac Os)',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Last active today at 07:06 pm',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: AppColors.errorRedColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
