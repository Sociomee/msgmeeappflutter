import 'package:flutter/material.dart';
import '../../theme/custom_theme.dart';

class ConncetWenPanelScreen extends StatelessWidget {
  const ConncetWenPanelScreen({super.key});

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
            'Scan QR code',
            style: TextStyle(color: CustomTheme.black),
          ),
        ),
        body: Column(children: [
          Image.asset('assets/qr.png'),
          Padding(
            padding: const EdgeInsets.only(bottom: 47, left: 47, right: 47),
            child: Text(
              'Open web.sociomee.com, desktop app, or other devices.',
              style: TextStyle(fontSize: 18, color: CustomTheme.white),
            ),
          )
        ]));
  }
}
