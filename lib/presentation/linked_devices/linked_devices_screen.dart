import 'package:flutter/material.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';

import '../../theme/custom_theme.dart';

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
      body: Column(
        children: [
          Image.asset('assets/linked_device.png'),
          Text('Use MsgMee On Your Website', style: TextStyle(fontSize: 23)),
          CustomButtonWidget(
              title: 'Scan A QR Code',
              color: CustomTheme.primaryColor,
              ontap: () {}),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Your personal messages will  on all your devices.',
                style: TextStyle(color: CustomTheme.grey)),
            TextSpan(
                text: 'end to end encrypted',
                style: TextStyle(color: CustomTheme.black)),
            TextSpan(
                text: 'end to end encrypted',
                style: TextStyle(color: CustomTheme.black)),
          ]))
        ],
      ),
    );
  }
}
